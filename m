Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314288AbSDRKVM>; Thu, 18 Apr 2002 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSDRKVL>; Thu, 18 Apr 2002 06:21:11 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59144 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314288AbSDRKVK>; Thu, 18 Apr 2002 06:21:10 -0400
Date: Thu, 18 Apr 2002 12:21:05 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Message-ID: <20020418102105.GB7884@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1589.1019123186@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002, Keith Owens wrote:

> + * Do not assume that the table from the linker is correct, sort it at boot
> + * time.  Since 90%+ of the entries will be sorted, a bubble sort is good
> + * enough, it only runs once per table per boot.  The sort only does binary
> + * keys and only sorts in ascending order.

Any real-world figures on how long this sort process would take on big
tables on some sparc or i586 class box? (Just trying to figure if bubble
is really adequate. It is if the table is indeed essentially sorted with
only like 10 reversed neighbours or if it's short.)
