Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271764AbRHURsj>; Tue, 21 Aug 2001 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271765AbRHURsb>; Tue, 21 Aug 2001 13:48:31 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:57832 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271764AbRHURsS>;
	Tue, 21 Aug 2001 13:48:18 -0400
Date: Tue, 21 Aug 2001 18:48:26 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: cfs+linux-kernel@cowlabs.com, "'Marco Colombo'" <marco@esi.it>,
        "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>
Cc: "'David Wagner'" <daw@mozart.cs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: /dev/random in 2.4.6
Message-ID: <2348880141.998419706@[10.132.112.53]>
In-Reply-To: <000801c12a63$9c9d54d0$0a90a5c7@cowlabs.com>
In-Reply-To: <000801c12a63$9c9d54d0$0a90a5c7@cowlabs.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I dunno about you, but I want good random for session keys too!  You can
> still capture network traffic and decrypt at your leisure if you can
> determine what the "random" number was used in making the session key.

That's why the pool is hashed before use. Modulo the seeding issue,
there is an implicit assumption in this argument that EITHER the
hash is breakable, OR we might as well scrap the entropy stuff entirely
and never block and speed up lots of applications that occasionally
block as a biproduct. The position that the hash is unbreakable
and never will be breakable, BUT we still need to block, is only
tenable in the context of initial seeding (AFAICS).

--
Alex Bligh
