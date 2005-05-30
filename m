Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVE3NRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVE3NRs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVE3NRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:17:48 -0400
Received: from tms.rz.uni-kiel.de ([134.245.11.89]:47291 "EHLO
	tms.rz.uni-kiel.de") by vger.kernel.org with ESMTP id S261156AbVE3NRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:17:46 -0400
Subject: Re: TPM on IBM thinkcenter S51
From: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
To: trusted linux <tcimpl2005@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050527204214.31693.qmail@web61018.mail.yahoo.com>
References: <20050527204214.31693.qmail@web61018.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 30 May 2005 15:17:51 +0200
Message-Id: <1117459071.6058.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 13:42 -0700, trusted linux wrote:
 
> I can't make TPM work on an IBM thinkcenter S51
> running 2.6.12-rc5 kernel. Here is what I did:
>  
> 1. build the drivers tpm.ko and tpm_nsc.ko and
> modprobe tpm
> 2. create /dev/tpm
> 3. build tpm libtcpa (version 1.1)
> 4. run tcpa_demo 
>  
> then I got an error "Can't open TPM driver". 

I'd check with strace first what's going on there. In my case I
had /dev/tpm0 created by udev with libtcpa accessing /dev/tpm. So -
what's the output of 

	strace ./tcpa_demo

??

Greetings

	Torsten

