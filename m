Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281836AbRKRBZ1>; Sat, 17 Nov 2001 20:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281839AbRKRBZQ>; Sat, 17 Nov 2001 20:25:16 -0500
Received: from holomorphy.com ([216.36.33.161]:55435 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281836AbRKRBZJ>;
	Sat, 17 Nov 2001 20:25:09 -0500
Date: Sat, 17 Nov 2001 17:24:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011117172437.B11913@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011118005819.3762.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011118005819.3762.qmail@science.horizon.com>; from linux@horizon.com on Sun, Nov 18, 2001 at 12:58:19AM -0000
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my bootmem patch, I wrote:
>> #define DIV_DN(x,n) (RND_DN(x,n) / (n))
>> #define DIV_UP(x,n) (RND_UP(x,n) / (n))

On Sun, Nov 18, 2001 at 12:58:19AM -0000, linux@horizon.com wrote:
> Eww.  I realize it's not performance-critical, but how about
> the simpler
> #define DIV_DN(x,n) ((x) / (n))
> #define DIV_UP(x,n) DIV_DN((x)+(n)-1, n)
> 
> There are some alternate definitions of RND_UP available, as well:
> #define RND_UP(x,n) (-RND_DN(-(x),n))
> or
> #define RND_UP(x,n) (~(~(x) | (n)-1))

I hope you don't mind my Cc:'ing lkml in my reply.

These are both excellent points. In the interest of economy of CPU, I
will follow your suggestions in the next installment (and list you in
the changelog =).


Thanks,
Bill
