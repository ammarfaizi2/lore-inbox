Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272274AbRHXRZx>; Fri, 24 Aug 2001 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272273AbRHXRZn>; Fri, 24 Aug 2001 13:25:43 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:15494 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272274AbRHXRZZ>;
	Fri, 24 Aug 2001 13:25:25 -0400
Date: Fri, 24 Aug 2001 18:25:33 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Woodhouse <dwmw2@infradead.org>,
        Tim Walberg <twalberg@mindspring.com>
Cc: "J. Imlay" <jimlay@u.washington.edu>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: macro conflict 
Message-ID: <2606707256.998677533@[10.132.112.53]>
In-Reply-To: <14764.998658214@redhat.com>
In-Reply-To: <14764.998658214@redhat.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

># define real_min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y);
># (_x>_y)?_y:_x; })
>
># define min(x,y) ({ if strcmp(STRINGIFY(typeof(x)), STRINGIFY(typeof(y)))
># BUG(); realmin(x,y) })
>
> /me wonders if gcc would manage to optimise that.

Will this work with things like

void test(unsigned int foo, char bar)
{
	printf ("%d %d\n", min(foo, 10), min (bar, 20));
}

Surely one of those must BUG().

--
Alex Bligh
