Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpIKSdcCfMheLSm+LCNYDdNtj9Q==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 16:28:45 +0000
Message-ID: <022201c415a4$82921c90$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:58 +0100
Content-Class: urn:content-classes:message
Importance: normal
From: "Dave Jones" <davej@redhat.com>
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: "Mikael Pettersson" <mikpe@csd.uu.se>, <szepe@pinerecords.com>,
        <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M config option for 2.6
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rob Love <rml@ximian.com>, Mikael Pettersson <mikpe@csd.uu.se>,
	szepe@pinerecords.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1073228608.2717.39.camel@fur>
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:58.0343 (UTC) FILETIME=[829E0370:01C415A4]

On Sun, Jan 04, 2004 at 10:03:28AM -0500, Rob Love wrote:
 > On Sun, 2004-01-04 at 07:27, Mikael Pettersson wrote:
 > > And since P-M doesn't do SMP, does cache line size even
 > > matter? There are no locks to protect from ping-ponging.
 > 
 > Cache line size does still come into the picture on UP, albeit not as
 > much as with SMP - but e.g. it still matters to things like device
 > drivers doing DMA.

Regardless, Tomas's patch changed CONFIG_X86_L1_CACHE_SHIFT for
that CPU, and CONFIG_X86_L1_CACHE_SHIFT shouldn't affect this.
The cacheline size is determined at boottime using the code in
pcibios_init() and set using pci_generic_prep_mwi().

The config option is the default that pci_cache_line_size starts at,
but this gets overridden when the CPU type is determined.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
