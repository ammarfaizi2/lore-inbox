Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSAEOtd>; Sat, 5 Jan 2002 09:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSAEOtX>; Sat, 5 Jan 2002 09:49:23 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:39439 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288827AbSAEOtM>;
	Sat, 5 Jan 2002 09:49:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Unbork fs.h + per-fs supers -> dontuse
Date: Sat, 5 Jan 2002 15:53:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <E16MnM9-0001Fu-00@starship.berlin>
In-Reply-To: <E16MnM9-0001Fu-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MsC5-0001H4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use the above patch please, there's a stupid oversight - it seems 
super_block has a couple of fields *after* the fs-private union, and the new 
code doesn't take that into account.  The plan is:

  a) get some sleep
  b) then fix it

--
Daniel
