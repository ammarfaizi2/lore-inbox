Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVLLXVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLLXVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLLXVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:21:20 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:23206 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932202AbVLLXVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:21:19 -0500
Message-ID: <439E06C3.7000304@keyaccess.nl>
Date: Tue, 13 Dec 2005 00:24:51 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <200506011643.42073.david-b@pacbell.net> <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz> <200506011917.14678.david-b@pacbell.net> <429F075F.7030804@keyaccess.nl> <42F3E95B.4050704@keyaccess.nl> <20050917023639.B49481FF9E@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <432C2BF1.1040100@keyaccess.nl>
In-Reply-To: <432C2BF1.1040100@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

(thread at http://marc.theaimsgroup.com/?t=111749614000002&r=1&w=2)

> David Brownell wrote:

>> -    if (!head->qh_next.qh) {
>> +    if (!head->qh_next.qh && !ehci->reclaim) {
> 
> 
> Thanks, but unfortunately no change. That is, still have that "Async" 
> status flag toggling on and off in /sys/class/usb_host/usb?/registers 
> (and the ~ 8MB/s drop in IDE throughput).

Maybe useful informateion: no problems when the disk is accessed through 
uhci-hcd at the same port. Only using it through ehci-hcd triggers the 
problem ("async" status flag toggling on/off, drop in IDE throughput).

Rene.



