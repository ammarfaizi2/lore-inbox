Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935605AbWK3Kmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935605AbWK3Kmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935597AbWK3Kmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:42:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:58838 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935593AbWK3Kmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:42:54 -0500
Message-ID: <456EB5A8.2060107@pobox.com>
Date: Thu, 30 Nov 2006 05:42:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Peer Chen <pchen@nvidia.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
References: <15F501D1A78BD343BE8F4D8DB854566B0D588DC0@hkemmail01.nvidia.com>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0D588DC0@hkemmail01.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer Chen wrote:
> Move the device IDs of MCP65/MCP67 from sata_nv.c to ahci.c.
> The patch will be applied to kernel 2.6.19.
> Please check attachment for the patch.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Please update as follows:

1) Provide a detailed explanation as to /why/ this is needed.  I 
certainly encourage use of ahci over legacy mode, but the patch 
description tells us nothing.

2) Combine the two patches into one.  Think of a patch as an atomic 
operation.  If you apply your patches as submitted, then a 'git bisect' 
may reach a state where the PCI IDs exist in _neither_ sata_nv or ahci. 
  Any time you /move/ code or data, it should be in the same patch.

3) Your patches are completely unreviewable in a standard Internet 
mailer, because they were sent with your email base64-encoded.  For many 
mailers, base64 encoding means the patch is not shown nor able to be 
commented upon.  Indeed, some mailers make it difficult to response -at 
all- to data contained in a MIME attachment.

The change itself seems OK, once suitable justification is provided.

	Jeff


