Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUENSqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUENSqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUENSqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:46:18 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:11692 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262071AbUENSqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:46:07 -0400
From: Jan Killius <jkillius@arcor.de>
Reply-To: jkillius@arcor.de
To: linux-kernel@vger.kernel.org
Subject: irq problem with nvidia driver
Date: Fri, 14 May 2004 20:46:04 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405142046.04276.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
there is some irq problem with the nvidia kernel module. After running the 
xserver for a while it freezes:
Badness in pci_find_subsys at drivers/pci/search.c:167

Call Trace:<IRQ> <ffffffff801fb773>{pci_find_subsys+83} 
<ffffffff801fb862>{pci_find_slot+50}
       <ffffffffa0025da0>{:nvidia:os_pci_init_handle+32} 
<ffffffffa00417ba>{:nvidia:_nv000904rm+24}
       <ffffffffa0197587>{:nvidia:_nv000711rm+897} 
<ffffffff802b14f8>{qdisc_restart+24}
       <ffffffffa01176f3>{:nvidia:_nv001272rm+51} 
<ffffffffa0116868>{:nvidia:_nv001217rm+28}
       <ffffffffa0196fd6>{:nvidia:_nv000704rm+46} 
<ffffffffa00f99ae>{:nvidia:_nv002988rm+438}
       <ffffffff802bdc43>{ip_send_reply+611} 
<ffffffffa0117914>{:nvidia:_nv001209rm+38}
       <ffffffffa0103de5>{:nvidia:_nv001835rm+2457} 
<ffffffffa0042b0a>{:nvidia:_nv000719rm+62}
       <ffffffffa0042d8f>{:nvidia:_nv000858rm+103} 
<ffffffffa00f7f41>{:nvidia:_nv002967rm+1907}
       <ffffffffa0116460>{:nvidia:_nv001214rm+112} 
<ffffffffa0042f32>{:nvidia:_nv000884rm+16}
       <ffffffffa0165527>{:nvidia:_nv001134rm+723} 
<ffffffffa00448aa>{:nvidia:_nv005317rm+112}
       <ffffffffa0046249>{:nvidia:rm_isr_bh+9} 
<ffffffff80136e54>{tasklet_action+68}
       <ffffffff80136b23>{__do_softirq+83} <ffffffff80136bb5>{do_softirq+53}
       <ffffffff8011209f>{do_IRQ+383} <ffffffff8010f8f5>{ret_from_intr+0}
        <EOI> <ffffffff8010f372>{system_call+126}

-- 
        Jan

