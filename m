Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUCASgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUCASgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:36:18 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:59559 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261396AbUCASgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:36:16 -0500
Date: Mon, 1 Mar 2004 18:34:41 +0000
From: Dave Jones <davej@redhat.com>
To: Christoph Terhechte <ct@fdk-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: drm:drm_init Cannot initialize the agpgart module
Message-ID: <20040301183441.GA29415@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Terhechte <ct@fdk-berlin.de>,
	linux-kernel@vger.kernel.org
References: <57977.212.184.83.69.1078165110.squirrel@mail.fdk-filmhaus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57977.212.184.83.69.1078165110.squirrel@mail.fdk-filmhaus.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 07:18:30PM +0100, Christoph Terhechte wrote:

 > There was a hint on this list that "intel_agp" should be loaded, too. I
 > have a VIA based board, so I tried "via_agp". It loads alright, but the
 > outcame is the same (and it was unnecessary under 2.4.22 anyway).
 > 
 > Here's my system's lspci output:
 > 
 > 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
 > Controller (rev 13)
 > 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge
 > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]

You have a VIA southbridge, but an AMD north bridge (where agpgart lives)
Try modprobe amd-k7-agp

		Dave
