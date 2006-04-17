Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWDQPQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWDQPQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDQPQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 11:16:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:57573 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751100AbWDQPQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 11:16:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JlkhrTrvlP+fZSAko8tawqIhH176H15kEe6iASH2Y9k4AMeK30/SPJ0u/rmXjKhh3XKf4qAtRC6t8v3oK/t42ySoNeyJXSfVF+kSLb0usL5DM3c10sUJIJX0F+FXVz6uLOF19dbySfZv3rDI/6ZnpFKkxkz6hBhJOZtlfgJ+jaU=
Message-ID: <d120d5000604170816i5ea3d0b8m71e454dd5e49b6cd@mail.gmail.com>
Date: Mon, 17 Apr 2006 11:16:55 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Brad Campbell" <brad@wasp.net.au>
Subject: Re: 2.6.16.1 psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1 and ACPI
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44439FCE.50809@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44437793.20908@wasp.net.au>
	 <d120d5000604170522q54b4b6ftc263f16a649a99e7@mail.gmail.com>
	 <44439FCE.50809@wasp.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/06, Brad Campbell <brad@wasp.net.au> wrote:
> Dmitry Torokhov wrote:
> > On 4/17/06, Brad Campbell <brad@wasp.net.au> wrote:
> >> Apr 17 14:12:30 bklaptop kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> >> Apr 17 14:12:30 bklaptop last message repeated 4 times
> >> Apr 17 14:12:30 bklaptop kernel: psmouse.c: issuing reconnect request
> >>
> >> I know it's related to ACPI as if I kill all apps that poll the acpi interface the problem goes
> >> away. My issue is that when I do that, I sometimes forget to plug the machine in when it needs it
> >> (or suspend it to change the battery) and it winds up dead with no warning. So I *really* need my
> >> battery monitoring.
> >>
> >> I just don't recall having these problems, to this extent with earlier kernels. It's always been
> >> there, but I guess since I passed about 2.6.13 or thereabouts it has just gotten worse. 2.6.16.1 is
> >> almost unusable for serious work if I have anything monitoring the battery.
> >>
> >
> > I often do you have your apps polling battery? Changing to 1 or 2
> > minutes might help.
>
> All in all I have three apps that poll.. I've slowed them down a little and it still seems to
> co-incide with me typing or using the touchpad (Murphy is a swine like that). One polls once per
> minute, one polls every 30 seconds and one polls every 2 seconds!! (that one I can kill without
> losing any major functionality)
>

Would you mind telling me what these applications are? Hopefully they
only poll "status" and not "info" file. And 2 seconds is definitely
too high. It would be nice if you could reduce "pollers" to just 1
application though.

--
Dmitry
