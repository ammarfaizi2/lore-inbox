Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262271AbTCMMS5>; Thu, 13 Mar 2003 07:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTCMMS5>; Thu, 13 Mar 2003 07:18:57 -0500
Received: from unthought.net ([212.97.129.24]:35002 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262271AbTCMMSs>;
	Thu, 13 Mar 2003 07:18:48 -0500
Date: Thu, 13 Mar 2003 13:29:33 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: NetFlow export
Message-ID: <20030313122932.GB29730@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>
References: <87adfza5kb.fsf@deneb.enyo.de> <20030313114809.GA29730@unthought.net> <87znnz8oob.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87znnz8oob.fsf@deneb.enyo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 12:57:08PM +0100, Florian Weimer wrote:
> Jakob Oestergaard <jakob@unthought.net> writes:
> 
> > On Thu, Mar 13, 2003 at 12:07:00PM +0100, Florian Weimer wrote:
> >> Are there any patches which implement kernel-based NetFlow data
> >> export?
> >
> > Netramet works very well - it's userspace (and very flexible indeed).
> 
> According to the documentation, it can receive NetFlow data and
> process it, but it cannot generate such data.

I never used it to receive netflow data.

I used netramet to generate flow information on a linux-based backbone
router, and to periodically move the flow information to another node
for batch processing/analysis.

I used the netramet tools to extract that information from the netramet
"meter" (the flow measurement daemon running on the router), for storage
on the remote accounting/processing machine. Some custom Perl scripts
process the flow information thereafter.

You asked for netflow data export. Netramet can give you something
similar to netflow (I never used netflow, but from what I hear, netramet
is similar only more flexible).

> 
> > No need to clutter the kernel with an SNMP stack too, if you ask me.
> 
> NetFlow doesn't use a complicated packet format and is not based on
> SNMP.  You can parse version 5 or 7 packets in 10 lines of Perl code,
> using a few calls to "unpack".

With 10 lines of Perl you could do full ASN-1   ;)

Netramet uses SNMP for the data transport - and I am very much surprised
if Cisco does not use SNMP - but again, I did not use netflow so I
wouldn't know.

In any case, to the "end user", it's as simple as calling a tool saying
"get me my data" - whether it's SNMP based or not.

Point being; if what you want is flow information from a Linux router,
excellent user space software (both "meter" and retrieval/filtering
tools) already exist for that.

If you want something else, then I have completely misread your mails.
Please elaborate, in that case  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
