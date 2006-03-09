Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751993AbWCIPbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWCIPbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWCIPbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:31:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38874 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751993AbWCIPbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:31:42 -0500
Subject: Re: 2.6.16-rc5 huge memory detection regression
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <441003E5.3090904@ribosome.natur.cuni.cz>
References: <440D6581.9080000@ribosome.natur.cuni.cz>
	 <20060307041532.3ef45392.akpm@osdl.org>
	 <440D7BB8.40106@ribosome.natur.cuni.cz>
	 <20060307113631.36ac029d.akpm@osdl.org>
	 <1141765722.9274.105.camel@localhost.localdomain>
	 <441003E5.3090904@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Date: Thu, 09 Mar 2006 07:31:15 -0800
Message-Id: <1141918275.8599.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 11:31 +0100, Martin MOKREJ© wrote:
> copy_e820_map() start: 0000000100000000 size: 0000000230000000 end: 0000000330000000 type: 1
> copy_e820_map() type is E820_RAM 

copy_e820_map() is really the first place that the kernel sees what the
BIOS has put in the e820 map.  Since something is wrong _this_ early, I
really have to point the finger at the hardware again.  It simply didn't
tell Linux that there was RAM there.  

-- Dave

