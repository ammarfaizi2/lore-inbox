Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVDUGgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVDUGgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVDUGgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:36:32 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:49584 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbVDUGgX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:36:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oi3R+X/RMdh3GTOUYKH9Tdbxl1DqP6PaVOWS76QivpdSQljKVVEhsZHdg7YCOGqh6U2A0snwySTjBByrn2Lj7adoHKUoscGwMmClTcRoPdyQXtFNhFGvDZiQ0smURJ/vKB6mAZzIr85yzEXEejmA0OJ9EmhZy96scL8GRKse6HY=
Message-ID: <84144f0205042023366dc0b16@mail.gmail.com>
Date: Thu, 21 Apr 2005 09:36:18 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Subject: Re: [PATCH] remove some usesless casts
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
In-Reply-To: <4266C0C3.7070002@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050420065500.GA24213@wohnheim.fh-wedel.de>
	 <4266732A.6050508@lougher.demon.co.uk>
	 <20050420213336.GA22421@wohnheim.fh-wedel.de>
	 <4266C0C3.7070002@lougher.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip,

Jörn Engel wrote:
> > Your definition of _unnecessary_ casts may differ from mine.
> > Basically, every cast is unnecessary, except for maybe one or two - if
> > that many.

On 4/20/05, Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
> Well we agree to differ then.  In my experience casts are sometimes
> necessary, and are often less clumsy than the alternatives (such as
> unions).  This is probably a generational thing, the fashion today is to
> make languages much more strongly typechecked than before.

I think Jörn means that if you need an opaque data type, use void
pointers (which are automatically cast to the proper type) and that
all other casts are a design smell (except for the one or two special
cases where you actually need them).

                                 Pekka
