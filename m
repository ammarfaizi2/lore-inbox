Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTEIWJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTEIWJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:09:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14344 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263535AbTEIWJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:09:20 -0400
Message-ID: <3EBC29E5.3030002@zytor.com>
Date: Fri, 09 May 2003 15:21:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC26BF.2080709@zytor.com> <3EBC29AD.5050203@redhat.com>
In-Reply-To: <3EBC29AD.5050203@redhat.com>
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
>>On the other
>>hand, how big of a performance issue is it really to call mmap() again
>>in the failure scenario *only*?
> 
> 
> Just look at the code, it's very expensive.  In the moment the mmap code
> has to sequentially look at the VMAs in question.  If it fails it means
> it walked the entire data structure without success.  Ingo's patch does
> not address this, it just makes successful allocation usually fast again.
> 

OK, maybe we should fix that instead :-/

	-hpa


