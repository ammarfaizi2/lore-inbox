Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpAgGdY4Rcb1ETCenMotIyg1JTg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 02:15:28 +0000
Message-ID: <008901c415a4$0806f4f0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:32 +0100
From: "Daniel Jacobowitz" <dan@debian.org>
To: <Administrator@osdl.org>
X-Mailer: Microsoft CDO for Exchange 2000
Cc: "Jakub Jelinek" <jakub@redhat.com>, <joe.korty@ccur.com>, <akpm@osdl.org>,
        <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
        <albert.cahalan@ccur.com>, <jim.houston@ccur.com>
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
Mail-Followup-To: Andi Kleen <ak@suse.de>, Jakub Jelinek <jakub@redhat.com>,joe.korty@ccur.com, akpm@osdl.org, torvalds@osdl.org,linux-kernel@vger.kernel.org, albert.cahalan@ccur.com,jim.houston@ccur.com
References: <20040102194909.GA2990@rudolph.ccur.com> <20040103012433.6aa4cafb.ak@suse.de> <20040103004406.GA24876@devserv.devel.redhat.com> <20040103020726.7c4397bc.ak@suse.de>
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20040103020726.7c4397bc.ak@suse.de>
User-Agent: Mutt/1.5.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:35.0250 (UTC) FILETIME=[09907B20:01C415A4]

On Sat, Jan 03, 2004 at 02:07:26AM +0100, Andi Kleen wrote:
> On Fri, 2 Jan 2004 19:44:06 -0500
> Jakub Jelinek <jakub@redhat.com> wrote:
> 
> > On Sat, Jan 03, 2004 at 01:24:33AM +0100, Andi Kleen wrote:
> > > > rt_sigqueueinfo(2) subverts this by reserving a range of si_code
> > > > values for users, and there is nothing about them to indicate to the
> > > > kernel which fields of siginfo_t are actually in use.  This is not a
> > > 
> > > My understanding was that the syscall always only supports si_int/si_ptr.
> > 
> > No, why?
> 
> Because otherwise it cannot be supported in the 32bit emulation. Or rather you
> won't get any conversion.

That's probably an acceptable limitation  I think what the OP pointed
out is that they _are_ converted, from 32-bit to 64-bit, when a 32-bit
process sends a siginfo to another 32-bit process, thereby garbling it.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
