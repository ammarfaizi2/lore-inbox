Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVAMNd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVAMNd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVAMNd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:33:56 -0500
Received: from blaster.systems.pipex.net ([62.241.163.7]:54145 "EHLO
	blaster.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261623AbVAMNaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:30:01 -0500
From: Shaheed <srhaque@iee.org>
To: Jan Frey <jan.frey@nokia.com>
Subject: Re: [PATCH] support for gzipped (ELF) core dumps
Date: Thu, 13 Jan 2005 13:29:51 +0000
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200501081727.52637.srhaque@iee.org> <1105617091.830.27.camel@borcx178>
In-Reply-To: <1105617091.830.27.camel@borcx178>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131329.51555.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 11:51, Jan Frey wrote:
> Hi,
>
> I tried to use those "in-kernel" functions, but they seem to do little
> different CRC calculations. Unfortunately I don't have any experiences
> with CRC stuff, anyone able to help here?

Do you know what polynomial you are trying to use? My first try wth Google 
gets me to:

http://www.cyphercalc.com/crctool.htm#LookupTables

not to mention a bunch of free sources such as:

http://www.repairfaq.org/filipg/LINK/F_crc_v35.html

which even implies that the pkzip polynomial *is* the standard one. If you 
really need the unrolled version for performance, at least use the right data 
types and/or consider to compute the tables at run time:

http://gcc.gnu.org/ml/gcc-patches/2002-04/msg01097.html

