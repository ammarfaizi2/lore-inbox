Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272006AbRHVNqf>; Wed, 22 Aug 2001 09:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271638AbRHVNqZ>; Wed, 22 Aug 2001 09:46:25 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:39329
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272009AbRHVNqU>; Wed, 22 Aug 2001 09:46:20 -0400
Message-ID: <3B83B80C.140A5146@nortelnetworks.com>
Date: Wed, 22 Aug 2001 09:47:56 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy> <20010821231002.C27313@bluemug.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Touloumtzis wrote:
 
> You have been repeating that there is no difference in security
> between /dev/random and /dev/urandom, but consider this: you install
> a kernel/hardware combination without any registered SA_SAMPLE_RANDOM
> IRQs (i.e. headless, no IDE, no NICs with SA_SAMPLE_RANDOM IRQs).
> This configuration is not hard to imagine for, say, a dedicated
> server appliance or embedded device.

So we then have two options, one of which is required if we are going to be able
to get any random numbers from this box:

1) if we contact some server to boot or to mount filesystems, we can also slurp
up some seed values from that server.
2) we enable all NIC drivers to collect entropy

In the case you describe, I don't see any other options.  Without one of these
paths, /dev/random will block, and /dev/urandom will be predictable.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
