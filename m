Return-Path: <linux-kernel-owner+w=401wt.eu-S1751716AbWLMWsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWLMWsW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWLMWsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:48:22 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37291 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbWLMWsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:48:21 -0500
Message-ID: <4580827F.8080703@zytor.com>
Date: Wed, 13 Dec 2006 14:45:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Rudolf Marek <r.marek@assembler.cz>, norsk5@xmission.com,
       lkml <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [RFC] new MSR r/w functions per CPU
References: <45807469.6040609@assembler.cz> <20061213221026.GF2418@redhat.com> <45807C88.6060807@zytor.com> <20061213222616.GJ2418@redhat.com>
In-Reply-To: <20061213222616.GJ2418@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> Can you explain this a little further? I'm fairly certain
> there are places in the kernel already doing this (or similar).
> In fact, I cut-n-pasted most of the above from similar code in the
> powernow-k8 driver.  What exactly can we deadlock on?
> 

I wanted to change the MSR driver to do the above, and Alan Cox objected 
that with realtime priority routines and/or user set affinity, that code 
might never be executed, so I retained the IPI-based code (which 
executes at the target processor at interrupt priority.)

	-hpa
