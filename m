Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287110AbRL2DkR>; Fri, 28 Dec 2001 22:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287112AbRL2DkI>; Fri, 28 Dec 2001 22:40:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:21009 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287111AbRL2Djz>;
	Fri, 28 Dec 2001 22:39:55 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
        linux-hams@vger.kernel.org
Subject: Re: link error in SCC driver 
In-Reply-To: Your message of "Fri, 28 Dec 2001 17:59:08 BST."
             <20011228165908.GL7481@wiggy.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 14:39:42 +1100
Message-ID: <9005.1009597182@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 17:59:08 +0100, 
Wichert Akkerman <wichert@wiggy.net> wrote:
>[maltimi;~/linux]-36> perl ../reference_discarded.pl 
>Finding objects, 443 objects, ignoring 0 module(s)
>Finding conglomerates, ignoring 37 conglomerate(s)
>Scanning objects
>Error: ./net/ipv4/netfilter/ip_nat_snmp_basic.o .text.lock refers to 0000004c R_386_PC32        .text.exit

Yep, the broader problem of lock handling in discarded sections leaving
dangling references in section .text.lock.  See [patch] 2.4.18-pre1
replace .text.lock with .subsection.
http://marc.theaimsgroup.com/?l=linux-kernel&m=100950122410373&w=2

