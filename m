Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756192AbWKVRz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbWKVRz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbWKVRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:55:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23494 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1756192AbWKVRzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:55:55 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dmitry Mishin <dim@sw.ru>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>
	<45633EDF.3050309@fr.ibm.com>
	<20061121181655.GA14656@MAIL.13thfloor.at>
	<456454C4.5010803@fr.ibm.com>
Date: Wed, 22 Nov 2006 10:53:57 -0700
In-Reply-To: <456454C4.5010803@fr.ibm.com> (Cedric Le Goater's message of
	"Wed, 22 Nov 2006 14:46:44 +0100")
Message-ID: <m1ejrvtlje.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

>> no problem here, but I think we will need another one,
>> or some smart way to do the network isolation (layer 3)
>> for the network namespace (as alternative to the layer 2
>> approach) ...
>
> My feeling (Dmitry and Daniel can correct me) is that it will be
> addressed with an unshare-like flag : NETNS2 and NETNS3.
>  
>> as they are both complementary in some way, I'm not sure
>> a single space will suffice ...
>
> hmm, so you think there could be a 2 differents namespaces
> for network to handle layer 2 or 3. Couldn't that be just a sub part
> of net_namespace.

The justification is performance and a little on the simplicity side.

My personal feel is still that layer 3 is something easier done
as a new kind of table in an iptables type infrastructure.  And in
fact I believe if done that way would capture do what 90%+ of what
all of the iptables rules do.  So it might be a nice firewalling speed up.

I don't think the layer 3 idea where you just do bind filter fits
the namespace concept very well.

Eric
