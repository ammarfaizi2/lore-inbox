Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264438AbRFIILd>; Sat, 9 Jun 2001 04:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264439AbRFIILX>; Sat, 9 Jun 2001 04:11:23 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:64260 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264438AbRFIILN>;
	Sat, 9 Jun 2001 04:11:13 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106090811.f598BBB505292@saturn.cs.uml.edu>
Subject: checker suggestion
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Sat, 9 Jun 2001 04:11:11 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200106090759.AAA15771@csl.Stanford.EDU> from "Dawson Engler" at Jun 09, 2001 12:59:24 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Struct padding is a problem. Really, there shouldn't be any
implicit padding. This causes:

1. security leaks when such structs are copied to userspace
   (the implicit padding is uninitialized, and so may contain
   a chunk of somebody's private key or password)

2. bloat, when struct members could be reordered to eliminate
   the need for padding
