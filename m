Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVCPMSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVCPMSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVCPMSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:18:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262552AbVCPMRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:17:05 -0500
Subject: Re: Devices/Partitions over 2TB
From: "Stephen C. Tweedie" <sct@redhat.com>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Stephen Tweedie <sct@redhat.com>, Bernd Eckenfels <ecki@lina.inka.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42366A79.2080609@utah-nac.org>
References: <E1DB3yF-0002BK-00@calista.eckenfels.6bone.ka-ip.net>
	 <42366A79.2080609@utah-nac.org>
Content-Type: text/plain
Message-Id: <1110975416.1959.21.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 16 Mar 2005 12:16:57 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-03-15 at 04:54, jmerkey wrote:

> Good Question.  Where are the standard tools in FC2 and FC3 for these types?

For LVM, the lvm2 package contains all the necessary tools.  I know
Alasdair did some kernel fixes for lvm2 striping on >2TB partitions
recently, though, so older kernels might not work perfectly if you're
using stripes.

To use genuine partitions > 2TB, though, you need alternative
partitioning; the GPT disk label supports that, and "parted" can create
and partition such disk labels.  (Note that most x86 BIOSes can't boot
off them, though, so don't do this on your boot disk!)

--Stephen


