Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWDXQtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDXQtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWDXQtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:49:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16593 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750906AbWDXQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:49:03 -0400
Subject: RE: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
In-Reply-To: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 18:47:57 +0200
Message-Id: <1145897277.3116.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 12:27 -0400, Makan Pourzandi (QB/EMC) wrote:
> Hi Arjan, 
> 
> I hope I correctly understood your question, DigSig uses LSM hooks to
> check the digital signature before loading it, then as long as your elf
> loader uses kernel system calls, it's covered by DigSig. 

ok I have to admit that this answer worries me.

how can it be covered? How do you distinguish an elf loader application
(which just uses open + mmap after all) with... say a grep-calling perl
script?

As long as you allow apps to mmap (or even just read() a file into
memory).... they can start acting like an elf loader if they chose to do
so. And.. remember it's not the files WITH signature you're protecting
against (which you could check) but the ones WITHOUT. And there are many
of those; and you can't sign ALL files I think, not without going
through really great hoops anyway.



