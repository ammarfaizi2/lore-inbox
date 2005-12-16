Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVLPNKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVLPNKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVLPNKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:10:12 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9922 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932382AbVLPNKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:10:11 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Neil Brown <neilb@suse.de>
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Date: Fri, 16 Dec 2005 15:09:01 +0200
User-Agent: KMail/1.8.2
Cc: Steven Rostedt <rostedt@goodmis.org>, linas <linas@austin.ibm.com>,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <1131412273.14381.142.camel@localhost.localdomain> <17263.64754.79733.651186@cse.unsw.edu.au>
In-Reply-To: <17263.64754.79733.651186@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161509.01580.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 03:18, Neil Brown wrote:
> On Monday November 7, rostedt@goodmis.org wrote:
> > 
> > This was for the simple reason, too many developers were passing
> > structures by value instead of by reference, just because they were
> > using a type that they didn't realize was a structure. And to make
> > things worse, these structures started to get bigger.
> > 
> 
> Another reason  for not using typedefs is that if you do, and you want
> to refer to the structure in some other include file, you have to
> #include the include file that devices the structure.
> If you don't use typedefs, you can just say:
> 
>    struct foo;

Forward decl for typedef works too:

typedef struct foo foo_t;

is ok even before struct foo is defined. Not sure that standards
allow thing, but gcc does.

> and the compiler will happily wait for the complete definition later
> (providing it doesn't need the size in the meanwhile). 
> So avoiding typedef means that you can sometimes avoid excess
> #includes, which means faster compiling.
--
vda
