Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264140AbTICRx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTICRx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:53:57 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:11945 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264140AbTICRxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:53:55 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: linux-kernel@vger.kernel.org
Subject: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Wed, 3 Sep 2003 18:53:01 +0100
User-Agent: KMail/1.5
Cc: rml@tech9.net, root@chaos.analogic.com, mochel@osdl.org,
       alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309031850.14925.jimwclark@ntlworld.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following my initial post yesterday please find attached my proposal for a 
binary 'plugin' interface:

This is not an attempt to have a Microkernel, or any move away from GNU/OSS 
software. I believe that sometimes the ultimate goals of stability and 
portability get lost in the debate on OSS and desire to allow anyone to 
contribute. It is worth remembering that for every Kernel hacker there must 
be 1000's of plain users. I believe this proposal would lead to better 
software and more people using it.

Proposal
-----------
1. Implement binary kernel 'plugin' interface
2. Over time remove most existing kernel 'drivers' to use new interface - This 
is NOT a Microkernel.
3. Design 'plugin' interface to be extensible as possible and then rarely 
remove support from interface. Extending interface is fine but should be done 
in a considered way to avoid interface bloat. Suggest interface supports 
dependant 'plugins'
4. Allow 'plugins' to be bypassed at boot - perhaps a minimal 'known good' 
list
5. Ultimately, even FS 'plugins' could be created although IPL would be 
required to load these. 
6. Code for Kernel, Interface and 'plugins' would still be GPL. This would not 
prevent the 'tainted' system idea. 

Expected Outcomes
------------------------

1. Make Linux easier to use
2. The ability to replace even very core Kernel components without a restart.
3. Allow faulty 'plugins' to be fixed/replaced in isolation. No other system 
impact.
4. 'Plugins' could create their own interfaces as load time. This would remove 
the need to pre-populate /dev. 
5. Remove need for joe soap user to often recompile Kernel.
6. Remove link between specific module versions and Kernel versions.
7. Reduce need for major Kernel releases. Allow effort to concentrate on 
improving Kernel not maintaining ever increasing Kernel source that includes 
support for the 'Kitchen Sink'
8. Make core Kernel more stable. Less releases and less changes mean less 
bugs. It would be easy to identify offending 'plugin' by simply starting up 
the Kernel with it disabled.
9. Remove need for modules to be maintained in sync with each Kernel thus 
freeing 'module' developers to add improved features or work on new projects.

James


