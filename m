Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSGUQiq>; Sun, 21 Jul 2002 12:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGUQiq>; Sun, 21 Jul 2002 12:38:46 -0400
Received: from ns.suse.de ([213.95.15.193]:29200 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316530AbSGUQip>;
	Sun, 21 Jul 2002 12:38:45 -0400
Date: Sun, 21 Jul 2002 18:41:51 +0200
From: Dave Jones <davej@suse.de>
To: Markus Pfeiffer <profmakx@profmakx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU detection broken in 2.5.27?
Message-ID: <20020721184151.A17463@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
References: <200207211537.03813.mcp@linux-systeme.de> <3D3ADC3E.9050307@milliways.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3ADC3E.9050307@milliways.de>; from profmakx@profmakx.org on Sun, Jul 21, 2002 at 06:07:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 06:07:26PM +0200, Markus Pfeiffer wrote:

 > I just noticed that my /proc/cpuinfo states wrong or incomplete 
 > information about my processor. My PIII-1000M Processor is reported as 
 > 00/0B (Stepping?)

Yep, I told Patrick about this last week sometime. The problem is
that only later Intels (from P4 onwards iirc) have the
name string cpuid function. Without which we need a table to
do the family/model/stepping translation to name strings.

It's not that much work (and most of it already exists in the
kernels before the per-cpu split up).

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
