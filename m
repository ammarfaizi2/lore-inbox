Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWEHPHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWEHPHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEHPHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:07:24 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:54026 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932363AbWEHPHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:07:23 -0400
Message-ID: <445F5EA9.5030200@argo.co.il>
Date: Mon, 08 May 2006 18:07:21 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Madhukar Mythri <madhukar.mythri@wipro.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: How to read BIOS information
References: <445F5228.7060006@wipro.com> <1147099994.2888.32.camel@laptopd505.fenrus.org> <445F5DF1.3020606@wipro.com>
In-Reply-To: <445F5DF1.3020606@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2006 15:07:21.0705 (UTC) FILETIME=[1B286D90:01C672B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Madhukar Mythri wrote:
> "proc/cpuinfo" says only HT support is their or not but, it will not 
> say whether HT is Enalbled/Disabled..
> How to read ACPI tables ? Can  you give little info on this...
> even from Driver program, if its possible please tell me...

Look at the 'physical id', 'siblings', 'core id', and 'cpu cores' fields 
in /proc/cpuinfo. If 'siblings' exists, you are hyperthreaded and you 
can detect which cpu the other thread is by matching physical id and 
core id.

-- 
error compiling committee.c: too many arguments to function

