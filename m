Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273682AbRIWW55>; Sun, 23 Sep 2001 18:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272467AbRIWW5t>; Sun, 23 Sep 2001 18:57:49 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:49924 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273688AbRIWW5e>; Sun, 23 Sep 2001 18:57:34 -0400
Date: Mon, 24 Sep 2001 00:57:57 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, zefram@fysh.org,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
Message-ID: <20010924005757.D17310@emma1.emma.line.org>
Mail-Followup-To: Nadav Har'El <nyh@math.technion.ac.il>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, zefram@fysh.org,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <E15kyyG-0000mq-00@dext.rous.org> <E15lFVk-0000Ex-00@the-village.bc.nu> <20010923234111.A16873@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010923234111.A16873@leeor.math.technion.ac.il>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Nadav Har'El wrote:

> Just too bad Debian's policy is to make ^? the erase character - pretty
> much the opposite of what most Unix users used before that. Pretending
> ASCII BS (^H) doesn't exist any more is an interesting exercise, but
> it isn't easy to change habits and standards that existed for a couple of
> decades... The same problem exists for the ASCII DEL (^?) which was also used
> in many Unix systems, but usually as a intr key, not a "delete-forward" type
> of thing...

[OT RANT]

Well, it's also fun to log in to a Solaris 2.5.1 ksh (which doesn't talk
bind, but just alias and soft-keys) from a Linux xterm which sends funny
Esc [3~ sequences. You can "fix" that with "Del sends Del", but you then
end up having either Del and Backspace both do Backspace or have their
meanings reversed from what the "left array" on the Backspace key
suggests. The Linux TTYs behave the same way (sending Esc [3~), and you
don't easily fix that without confusing EOF detection or things.

As appreciable a solution to consistently make "Delete" do
"delete-forward" and "Backspace" do "delete-backward" would be, as low
are the chances to get this done before the year 2039.
