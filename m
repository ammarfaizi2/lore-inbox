Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSGQRxx>; Wed, 17 Jul 2002 13:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGQRxx>; Wed, 17 Jul 2002 13:53:53 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:22205 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316187AbSGQRxw>;
	Wed, 17 Jul 2002 13:53:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 19:57:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D3500AA.131CE2EB@zip.com.au>
In-Reply-To: <3D3500AA.131CE2EB@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Ut3V-0004OY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 07:29, Andrew Morton wrote:
> 11: The nightly updatedb run is still evicting everything.

That is not a problem with rmap per se, it's a result of not properly 
handling streaming IO.  I don't think you want to get bogged down in this 
detail at the moment, it will only distract from the real issues.  My 
recommendation is to just pretend for the time being that this is correct 
behaviour.

On the other hand, if updatedb is pushing you into swap, that's a bug.

-- 
Daniel
