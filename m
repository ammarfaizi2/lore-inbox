Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272518AbRIKQjh>; Tue, 11 Sep 2001 12:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272517AbRIKQj2>; Tue, 11 Sep 2001 12:39:28 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:64530 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272511AbRIKQjJ>; Tue, 11 Sep 2001 12:39:09 -0400
Date: Tue, 11 Sep 2001 18:39:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: kuznet@ms2.inr.ac.ru
Cc: matthias.andree@gmx.de, alan@lxorguk.ukuu.org.uk, wietse@porcupine.org,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010911183928.A7711@emma1.emma.line.org>
Mail-Followup-To: kuznet@ms2.inr.ac.ru, alan@lxorguk.ukuu.org.uk,
	wietse@porcupine.org, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20010910221448.E30149@emma1.emma.line.org> <200109111522.TAA16406@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200109111522.TAA16406@ms2.inr.ac.ru>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2001, kuznet@ms2.inr.ac.ru wrote:

> A. No way to do the trick with SIOCSIF*.

Well, ioctl cannot configure IP aliases, however. Indeed, it may be
useful to change the patch to not touch the SIOCS* functions and
document that it only accesses the first one.

> B. The things does not become simpler when code does something random.
>    The things become simpler when code checks something explicitly,
>    otherwise you have to add comment: "Well, here we do this against
>    plain logic, but this does not matter because of this, this and this."

That's true, but I would not want to make SIOCGIFADDR behave differently
than SIOCGIFNETMASK, in that case, I'd rather have SIOCGIFCONF just
return the first address per interface name.

I will prepare a new patch as my time permits (unless, of course,
someone is faster).

-- 
Matthias Andree
Outlook (Express) users: press Ctrl+F3 for the full source code of this post.
begin  dont_click_this_virus.exe
end
