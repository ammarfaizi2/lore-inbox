Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTEIUnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTEIUnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:43:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263437AbTEIUnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:43:24 -0400
Message-ID: <3EBC15B5.4070604@zytor.com>
Date: Fri, 09 May 2003 13:55:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com>
In-Reply-To: <3EBC0084.4090809@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> H. Peter Anvin wrote:
> 
> 
>>How about this: since the address argument is basically unused anyway
>>unless MAP_FIXED is set, how about a MAP_MAXADDR which interprets the
>>address argument as the highest permissible address (or lowest
>>nonpermissible address)?
> 
> 
> You miss the point of my initial mail: I need a way to say "preferrably
> 32bit address, otherwise give me what you have".  MAP_32BIT already
> provides a way to require 32 bit addresses.
> 

No, it requires 31-bit addresses, and there was a discussion about how
some things need 31-bit and some 32-bit addresses.  There might also be
a need for 39-bit addresses, to be compatible with Linux 2.4.

MAP_MAXADDR_ADVISORY?

	-hpa


