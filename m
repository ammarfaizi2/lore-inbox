Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVDFNK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVDFNK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVDFNK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:10:58 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:21911 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262198AbVDFNKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:10:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lQ4JNqhTINw3WnHJ6a13FQvpNMKklnLcCvU77qvOaqNyoD7XQqWnPEB8nUn7AKVfA4Udi2ex6fkdyFy78jI9beAi3nNnGTzWJvV/lfbmQ1WfxAt1iwTTDHsqojXxI1DZFcP4qIR4NYZEEiwx2Rwto/+DARE9/0QxEq2Iyjlk+UQ=
Message-ID: <84144f02050406061077de4c2e@mail.gmail.com>
Date: Wed, 6 Apr 2005 16:10:52 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Jesper Juhl <juhl-lkml@dif.dk>, Roland Dreier <roland@topspin.com>,
       LKML <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi
In-Reply-To: <4253D2CD.2040600@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4252BC37.8030306@grupopie.com>
	 <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost>
	 <521x9pc9o6.fsf@topspin.com>
	 <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost>
	 <20050406112837.GC7031@wohnheim.fh-wedel.de>
	 <4253D2CD.2040600@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Apr 6, 2005 3:15 PM, Paulo Marques <pmarques@grupopie.com> wrote:
> However "calloc" is the standard C interface for doing this, so it makes
> some sense to use it here as well... :(

I initally submitted kcalloc() with just one parameter but Arjan
wanted it to be similar to standard calloc() so we could check for
overflows. I don't see any reason not to introduce kzalloc() for the
common case you mentioned (as suggested by Denis).

                                     Pekka
