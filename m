Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVEaTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVEaTtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVEaTtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:49:55 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:51962 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261354AbVEaTtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:49:53 -0400
Message-ID: <429CBFE6.7030107@robotech.de>
Date: Tue, 31 May 2005 21:49:58 +0200
From: Tobias Reinhard <tracer@robotech.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with concurrent SATA-Writes
References: <429C9BFA.5090901@robotech.de> <20050531190008.GJ23621@csclub.uwaterloo.ca>
In-Reply-To: <20050531190008.GJ23621@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
 > Might it be a problem with having two things using /dev/zero at the same
 > time?
No, dding from /dev/zero two times at the same time is working perfectly

 > What blocksize do you use with dd?
Generally I use 1M. But the Problem is the same with 128k or with 4k

 > What happens if you do dd from /dev/zero to two different files on one
 > of the hds (with some filesystem on the drive obviously)?
I did it without a FS on it and its no problem to write at two different 
locations - as long as they are on one disc.

It seems to me that the driver has problems with handling two 
write-requests on two ports at the same time.

Tobias
