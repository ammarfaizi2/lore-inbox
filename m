Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBOP3u>; Thu, 15 Feb 2001 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRBOP3k>; Thu, 15 Feb 2001 10:29:40 -0500
Received: from colorfullife.com ([216.156.138.34]:39180 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129093AbRBOP32>;
	Thu, 15 Feb 2001 10:29:28 -0500
Message-ID: <3A8BF5ED.1C12435A@colorfullife.com>
Date: Thu, 15 Feb 2001 16:29:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Jeremy Jackson <jeremy.jackson@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> But the gcc bounds checking work is the ultimate buffer overflow fix.
> You can recompile all of your trusted applications, and libraries with
> it and be safe from one source of bugs.
>

void main(int argc, char **argv[])
{
	char local[128];
	if(argc > 2)
		strcpy(local,argv[1]);
}

Unless you modify the ABI and pass the array bounds around you won't
catch such problems, and I won't even mention unions and

struct dyn_data {
	int len;
	char data[];
}

--
	Manfred
