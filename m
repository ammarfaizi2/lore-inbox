Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275027AbRIYPNQ>; Tue, 25 Sep 2001 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275033AbRIYPNG>; Tue, 25 Sep 2001 11:13:06 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:39697 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275027AbRIYPM5>; Tue, 25 Sep 2001 11:12:57 -0400
Date: Tue, 25 Sep 2001 17:13:20 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010925171320.B22622@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010925021113.B22073@emma1.emma.line.org> <107194016.1001432841@[10.132.113.67]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <107194016.1001432841@[10.132.113.67]>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Alex Bligh - linux-kernel wrote:

> Probably because sectors are so close together on the physical media.
> If you disable write caching, and are writing sectors 1001, 1002, 1003
> etc., you tell it to write sector 1001, and it doesn't complete until
> it's written it, you IRQ the PC, and it sends the write out for 1002,
> which completes a little later. However, by this time 1002 has
> flown past the drive head, as it wasn't immediately queued on the drive.
> If you had only one sector of writeahead, this effect would disappear
> (but is just as theoretically dangerous if there is no way to force
> a flush() of the write cache).

Which leads me to the question: which ATA standard brought up the
mandatory FLUSH CACHE command? I saw it's in the ATA 6 draft. How about
standards used in drives that are sold today? ATA 4, ATA 5? Do they have
the FLUSH CACHE command listed, possibly as mandatory? That might be
rather useful to use after in a "synchronous" write.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
