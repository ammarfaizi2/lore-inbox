Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273994AbRIXQ3g>; Mon, 24 Sep 2001 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRIXQ30>; Mon, 24 Sep 2001 12:29:26 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:65015 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273994AbRIXQ3N>; Mon, 24 Sep 2001 12:29:13 -0400
Subject: Re: __alloc_pages: 0-order allocation failed
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 24 Sep 2001 11:35:41 +0000
Message-Id: <1001331342.4610.49.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch helped for me, but there are still problems.  I was able to
run all the way through LTP without it shutting anything down.  When I
used one of the memory tests to chew up all the ram though, I noticed
that VM was killing things it shouldn't have.  First thing to get killed
was cron, then top, then it finally killed mtest01 (the memory test
mentioned before).

