Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313302AbSDLCAH>; Thu, 11 Apr 2002 22:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSDLCAG>; Thu, 11 Apr 2002 22:00:06 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:34702 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S313302AbSDLCAF>; Thu, 11 Apr 2002 22:00:05 -0400
Date: Thu, 11 Apr 2002 20:59:53 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7 Rules.make change break nfsd.
In-Reply-To: <15533.19747.471321.592478@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0204112055040.13828-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Neil Brown wrote:

> If the basename of some object is "export" (i.e. export.o), then the
> underlined section referes to "export-objs" which is a macro that
> already has a well defined meaning.
> 
> Maybe it should be "-Objs" or "-components" or ...

Hmmh, I did that change. Changing the -objs suffix is not really an 
option, as it's being used all over the makefiles already. But you're 
right, this conflict needs to be resolved. 

(It also means nobody can build a multi-part object called export.o, but I
suppose that's a limitation we can live with it.)

I think I'll just filter out export.o at the affected places.

--Kai




