Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289850AbSBNGgb>; Thu, 14 Feb 2002 01:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290232AbSBNGgT>; Thu, 14 Feb 2002 01:36:19 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:57608 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S289850AbSBNGgH>;
	Thu, 14 Feb 2002 01:36:07 -0500
Message-ID: <3C6B5B09.48AF3140@yahoo.com>
Date: Thu, 14 Feb 2002 01:36:57 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
In-Reply-To: <E16aeHN-00020H-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Reminds me - we have a request_mem_region problem to address that is sort
> of related to all this. Right now we reserve mem regions without knowing
> properly about ISA mappings. That means drivers are reserving stuff like
> 0xD0000. Unfortunately on some non X86 boxes the ISA hole isnt at 640K-1M
> so it appears we want an  isa_request_mem_region and friends to handle those
> platforms ?               ^^^^^^^^^^^^^^^^^^^^^^

Minor nit, but if we go that route, maybe make it request_isa_mem_region() 
just to be consistent with all the other request_xxxx type functions ?

Paul.

