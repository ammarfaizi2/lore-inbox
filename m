Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272025AbRHVPKr>; Wed, 22 Aug 2001 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272027AbRHVPKh>; Wed, 22 Aug 2001 11:10:37 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:21404 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S272025AbRHVPK0>; Wed, 22 Aug 2001 11:10:26 -0400
Importance: Normal
Subject: Allocation of sk_buffs in the kernel
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF55D2E221.5E62CB41-ONC1256AB0.0052D2D3@de.ibm.com>
From: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Date: Wed, 22 Aug 2001 17:10:34 +0200
X-MIMETrack: Serialize by Router on d12ml040/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 22/08/2001 17:10:35
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'm currently writing a kernel patch where it is essential to get known
when a sk_buff is allocated. Or better said I have to get known when a
sk_buff is effectively a new packet in the kernel-

I currently identified 3 functions in the kernel where sk_buffs are
allocated: alloc_skb (of course), skb_linearize and pskb_expand_head. Or at
least there new data is defined for the sk_buffs.

Now I monitor a TCP session, a FTP download better said, and on the
interface arrives around 30000 packets for 50 MB of data. But in my kernel
patch only 2000 packets are allocated, or at least I see only the
allocation of 2000 packets.

Can anyone help me where I can find my missing packets? ;)) I need them
badly! *GG*

It's not quite easy to look into the TCP code, because its quite big and a
bit complicated.....

Thanks in advance!

Regards,
Jens

