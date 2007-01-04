Return-Path: <linux-kernel-owner+w=401wt.eu-S932268AbXADDQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbXADDQ0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXADDQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:16:26 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:13172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbXADDQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:16:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=mvrR46hczyLJzRMmBVMNSM4qr2L6jCWvC3p4TmyG/hdeo6mUn/QA7F+Bp68M+D8vipn5SrvHtOSRroCiF4KOyt6MjZQFbvJPzQfl7T2bs38lVE96b7JNIl5vHjIcbmtkr4PWp/0gMig2DhfrTDqc4DxcNiByHmV2S5fK8eCGUGo=
Message-ID: <459C7182.4020000@gmail.com>
Date: Thu, 04 Jan 2007 12:16:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: bbee <bumble.bee@xs4all.nl>
CC: Andrew Lyon <andrew.lyon@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com> <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org> <459B140C.1060401@gmail.com> <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org> <459B2DEA.8080202@gmail.com> <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
In-Reply-To: <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bbee wrote:
> Sorry, I thought you meant you would need to update it *further*. I
> applied the patch you gave to Andrew with this result so far:
> 
> $ dmesg | grep -A1 "spurious interrupt"
> ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
> ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000008
> -- 
> ata1: spurious interrupt (irq_stat 0x8 active_tag 0xfafbfcfd sactive 0x0)
> ata1: issue=0x0 SAct=0x0 SDB_FIS=004040a1:00000001

Ek... Your problem is similar too.

> No luck yet triggering the exception.
> 
> On Wed, 3 Jan 2007, Andrew Lyon wrote:
>> Alan said he was going to add the drive to a blacklist he was
>> maintaining for NCQ, perhaps that has been done in kernel 2.6.19, I
>> dont know as I am still running 2.6.18.
>>
>> Perhaps the WD Raptor drive that I have does have lousy NCQ and that
>> explains both the poor performance and the spurious interrupts.
> 
> Blacklisting NCQ on the drive(s) for all controllers might be ill
> advised, since it could be a JMicron-specific issue (or ahci-specific,
> since the person in the thread I referenced had a different ahci
> controller..). Either that, or both our drive models have "lousy NCQ"..

If it turns out to be drive's fault, I'm afraid there's no other
solution than blacklisting those drives on all controllers.  It's
protocol violation on drive's side, so I don't think there is an easy
way out here except for firmware upgrade.  I'm asking people about this,
so please be patient.

-- 
tejun
