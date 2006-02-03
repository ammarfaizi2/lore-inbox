Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWBCLFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWBCLFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWBCLFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:05:17 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:43013 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751036AbWBCLFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:05:15 -0500
Date: Fri, 3 Feb 2006 12:05:14 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Dave Jones <davej@redhat.com>, Avi Kivity <avi@argo.co.il>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
Message-ID: <20060203110514.GA27366@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Dave Jones <davej@redhat.com>, Avi Kivity <avi@argo.co.il>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il> <20060203014645.GD10209@redhat.com> <43E2BA63.5050505@argo.co.il> <20060203042035.GF10209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203042035.GF10209@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:20:35PM -0500, Dave Jones wrote:
> +		case 0x6a:	/* 01101010 bit 0 flipped */
> +		case 0x69:	/* 01101001 bit 1 flipped */
> +		case 0x6f:	/* 01101111 bit 2 flipped */
> +		case 0x63:	/* 01100011 bit 3 flipped */
> +		case 0x7b:	/* 01111011 bit 4 flipped */
> +		case 0x4b:	/* 01001011 bit 5 flipped */
> +		case 0x2b:	/* 00101011 bit 6 flipped */
> +		case 0xeb:	/* 11101011 bit 7 flipped */

What about simply:
  case 0x6b^0x01:
  case 0x6b^0x02:
  case 0x6b^0x04:
  case 0x6b^0x08:
  case 0x6b^0x10:
  case 0x6b^0x20:
  case 0x6b^0x40:
  case 0x6b^0x80:

  OG.
