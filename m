Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269101AbRGaAQi>; Mon, 30 Jul 2001 20:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269102AbRGaAQ2>; Mon, 30 Jul 2001 20:16:28 -0400
Received: from pD951F41A.dip.t-dialin.net ([217.81.244.26]:63239 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S269101AbRGaAQO>; Mon, 30 Jul 2001 20:16:14 -0400
Date: Tue, 31 Jul 2001 02:16:17 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731021617.B28253@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <s5gpuaiplwf.fsf@egghead.curl.com> <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Rik van Riel wrote:

> Exactly what is wrong with doing fsync() on the
> directory ?

It's non-portable and a kludge.

> Why do you want us to turn link() and rename()
> into link_slowly() and rename_slowly() ?

Opening up the directory requires lots of inode lookups which are
unnecessary.

> Why can't you use a simple wrapper function to
> do this for you ?

Because it's more inefficient than necessary and it bloats the
application.

-- 
Matthias Andree
