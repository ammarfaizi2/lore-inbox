Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSEKXQi>; Sat, 11 May 2002 19:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316282AbSEKXQh>; Sat, 11 May 2002 19:16:37 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:51098 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315245AbSEKXQg>; Sat, 11 May 2002 19:16:36 -0400
Message-Id: <5.1.0.14.2.20020512091518.03e53200@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 12 May 2002 09:17:25 +1000
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH]
  2.5.14  IDE 56)
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200205111418.g4BEIa629620@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:18 PM 11/05/2002 +0200, Roy Sigurd Karlsbakk wrote:
>Will the use of O_DIRECT affect disk elevatoring?

i believe the elevator is based on the 'block' layer and anything that goes 
thru it.  so the answer is that the requests would use the elevator.

for the test in question, i was doing sequential reads from the first block 
of each disk until some block later on in the disk.  (ie. a 2gbyte read or 
18gbyte read).
given that was the case and the only i/o ops were 'read' operations, 
elevator would make no difference here.


cheers,

lincoln.

