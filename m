Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSAAKc2>; Tue, 1 Jan 2002 05:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287801AbSAAKcS>; Tue, 1 Jan 2002 05:32:18 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:17938 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287798AbSAAKcE>;
	Tue, 1 Jan 2002 05:32:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tim Keating <tkeating@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another .text.exit error. 2.4.18pre1 
In-Reply-To: Your message of "Tue, 01 Jan 2002 02:17:32 PDT."
             <Pine.LNX.4.33.0201010206291.217-100000@darkspace.hidden.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jan 2002 21:31:50 +1100
Message-ID: <4450.1009881110@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jan 2002 02:17:32 -0700 (MST), 
Tim Keating <tkeating@shaw.ca> wrote:
>Using Keith Owens perl script I found in message;
>http://www.uwsg.indiana.edu/hypermail/linux/kernel/0112.3/0700.html
>Error: ./net/ipv4/netfilter/ip_nat_snmp_basic.o .text.lock refers to
>0000003c R_386_PC32        .text.exit

If you can do without nat for snmp then CONFIG_IP_NF_NAT_SNMP_BASIC=n.
Otherwise look for a patch with subject
  [patch] 2.4.18-pre1 replace .text.lock with .subsection
With any luck that patch will be in 2.4.18-pre2.

