Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271335AbRHXNDr>; Fri, 24 Aug 2001 09:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271307AbRHXNDh>; Fri, 24 Aug 2001 09:03:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:7154 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271283AbRHXND1>; Fri, 24 Aug 2001 09:03:27 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010823143440.G20693@mindspring.com> 
In-Reply-To: <20010823143440.G20693@mindspring.com>  <Pine.A41.4.33.0108231150110.64144-100000@dante14.u.washington.edu> 
To: Tim Walberg <twalberg@mindspring.com>
Cc: "J. Imlay" <jimlay@u.washington.edu>, linux-kernel@vger.kernel.org
Subject: Re: macro conflict 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2001 14:03:34 +0100
Message-ID: <14764.998658214@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


twalberg@mindspring.com said:
> There has already been **much** discussion about this, but I think
> that the bottom line is that the new version is safer and more robust
> than the old version, and thus is not likely to be changed back. 

That's a completely separate issue. You can fix it while keeping sane 
semantics for min() and max().

#define real_min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x; })

#define min(x,y) ({ if strcmp(STRINGIFY(typeof(x)), STRINGIFY(typeof(y))) BUG(); realmin(x,y) }) 

/me wonders if gcc would manage to optimise that.
--
dwmw2


