Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVBWMQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVBWMQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 07:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVBWMQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 07:16:10 -0500
Received: from web51509.mail.yahoo.com ([206.190.38.201]:62381 "HELO
	web51509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261475AbVBWMQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 07:16:05 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Te5qnadV3iep88yWAEMomZWGs7XWVolcmufHIiNQ11iOkcgwJJnx0xVq59AkjhoTLwnWioYybfwRTgJ4Hr4754hliYjEyc/gbnKiiI3L29N2rohZibFfLMbQbm0XzUydVmFIYuxY9Xdfvmro4pa2JbjfwwH3Wa4XKvTfLQAh8aI=  ;
Message-ID: <20050223121604.10279.qmail@web51509.mail.yahoo.com>
Date: Wed, 23 Feb 2005 04:16:04 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: [NET]: Add sock_create_kern()
To: jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-05-08 at 22:00, James Morris wrote:
> Under SELinux, and potentially other LSMs, we need 
> to be able to distinguish between user sockets and 
> kernel sockets.  For SELinux specifically, kernel 
> sockets need to be specially labeled during 
> creation, then bypass access control checks (they 
> are controlled by the kernel itself and not subject 
> to SELinux mediation).

Do both user sockets and kernel sockets have a socket
structure and a corresponding sock structure (i.e. a
BSD socket and a INET socket) with them?

In 8.1.1 of "Integrating Flexible Support for Security
Policies into the Linux Operating System", It says:
"The Linux network component creates two special
purpose sockets for use by the AF_INET protocol
family. The tcp socket is used to send resets when a
TCP packet is rejected, since there may be no local
socket corresponding to the packet. The icmp socket is
used to send ICMP messages.Two initial SIDs were
defined for these sockets, with the corresponding
security context determined by the security server."

Does the "local socket" here refer to the "user
socket" as you mentioned above?

Thank you very much.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Sports - Sign up for Fantasy Baseball. 
http://baseball.fantasysports.yahoo.com/
