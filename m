Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWCAUZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWCAUZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWCAUZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:25:57 -0500
Received: from madness.at ([217.196.146.217]:33507 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S1751024AbWCAUZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:25:55 -0500
Message-ID: <4406034B.9030105@madness.at>
Date: Wed, 01 Mar 2006 21:25:47 +0100
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Maxim Kozover <maximkoz@netvision.net.il>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: problems with scsi_transport_fc and qla2xxx
References: <1413265398.20060227150526@netvision.net.il>	<978150825.20060227210552@netvision.net.il> <20060228221422.282332ef.akpm@osdl.org>
In-Reply-To: <20060228221422.282332ef.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Maxim Kozover <maximkoz@netvision.net.il> wrote:
> 
>>Hi!
> 
> 
> (cc's added)
> 
> 
>>Most of the problem seems to be a QLogic driver problem.
>>HBAs are connected to target via FC switch.
>>
>>1. If I have several LUNs on each HBA, with QLogic only 1 directory
>>per adapter (for LUN 0) is created in /sys/class/fc_remote_ports,
>>while with Emulex a directory for every LUN is created.
>>
>>2. The situation I described occurs with QLogic only if the cable
>>connecting between HBA and switch is pulled out/in. If I
>>connect/disconnect the cable between switch and target, disks come
>>back.

I can confirm that very problem (pulling the cable between HBA and
switch results in only LUN 0 or nothing coming back afterward) on
2.6.15.4 here too.


Stefan
