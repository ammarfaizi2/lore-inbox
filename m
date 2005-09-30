Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVI3NFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVI3NFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVI3NFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:05:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030292AbVI3NFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:05:00 -0400
Date: Fri, 30 Sep 2005 09:04:46 -0400
From: Dave Jones <davej@redhat.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Wes Felter <wesley@felter.org>, linux-kernel@vger.kernel.org
Subject: Re: em64t speedstep technology not supported in kernel yet?
Message-ID: <20050930130446.GA15658@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Wes Felter <wesley@felter.org>, linux-kernel@vger.kernel.org
References: <88056F38E9E48644A0F562A38C64FB6005DECA92@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6005DECA92@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 05:20:03AM -0700, Pallipadi, Venkatesh wrote:
 > 
 > >-----Original Message-----
 > >From: linux-kernel-owner@vger.kernel.org 
 > >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Wes Felter
 > >Sent: Thursday, September 29, 2005 11:58 AM
 > >To: linux-kernel@vger.kernel.org
 > >Subject: Re: em64t speedstep technology not supported in kernel yet?
 > >
 > >Richard Wohlstadter wrote:
 > >> Hello all,
 > >> 
 > >> We recently had Intel give our company a roadmap 
 > >presentation where they 
 > >> told us that their enhanced speedstep technology was 
 > >supported by linux 
 > >> kernels 2.6.9+.  I have since tried to get cpufreq speedstep 
 > >driver to 
 > >> work with no luck on our em64t Xeon 3.6g processors.  Intel 
 > >even has a 
 > >> webpage describing the technology and how to get it working at url: 
 > >> http://www.intel.com/cd/ids/developer/asmo-na/eng/195910.htm?prn=Y
 > >
 > >I think this is a BIOS problem; the BIOS needs to provide the proper 
 > >ACPI frequency/voltage tables for cpufreq to use. You might want to 
 > >harass your system/motherboard vendor.
 > >
 > >Alternately maybe you can find someone who can give you the 
 > >secret table and then you can just hardcode it into the driver.
 > 
 > Yes. Make sure speedstep is  supported and enabled in BIOS. Typically,
 > there will be a BIOS config option under CPU section, called Speedstep, 
 > Enhanced Speedstep or EIST or something like that. 

The BIOS tables make no difference at all however to the speedstep-centrino
module  (which in retrospect really should have been speedstep-est or something)
as it has no OP() tables or cpu recognition for Xeons.

		Dave

