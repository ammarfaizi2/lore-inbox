Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTJKQ06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbTJKQ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:26:58 -0400
Received: from [38.119.218.103] ([38.119.218.103]:27852 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S261974AbTJKQ0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:26:53 -0400
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.045646 secs)
Date: Sat, 11 Oct 2003 11:26:51 -0500
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: Problem with de4x5 on Alpha?
Message-ID: <20031011162651.GA25489@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I've been trying to get 2.6.0-test[6|7] to boot on my AS2100 (Sable),
and have run into a problem.  If I disable networking, I can get the
machine to boot.  However if the rc script to start networking runs, the
machine hangs on it.  It's using the de4x5 driver for the NICs, but only
one interface out of the 5 possible is ever brought up.  I've only got a
serial console on the thing, so I don't know if anything gets printed to
the screen when this happens to indicate something.  However, when it
hangs I've done an Alt-SysRq-t to dump a trace, and then run the trace
through ksymoops to try and get some idea of what's happening.  Below
are three traces from when it hangs;  the first two are from booting
with smp enabled, and the third one is from when I booted with 'nosmp'.
Is there any other information I can collect to help debug this?
(Everything works fine with 2.4.21)


Trace; fffffc000032afac <show_state+9c/110>
Trace; fffffc0000429878 <sysrq_handle_showstate+18/30>
Trace; fffffc0000429c04 <__handle_sysrq_nolock+d4/1c0>
Trace; fffffc0000429b08 <handle_sysrq+68/90>
Trace; fffffc0000420404 <kbd_keycode+444/4a0>
Trace; fffffc00004204ac <kbd_event+4c/b0>
Trace; fffffc000048ddac <input_event+16c/4d0>
Trace; fffffc0000490cf4 <atkbd_interrupt+1f4/500>
Trace; fffffc000031ca20 <timer_interrupt+a0/180>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000495db4 <serio_interrupt+64/70>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000496cc8 <i8042_interrupt+178/230>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc00003f9590 <_outb+0/30>
Trace; fffffc0000327e34 <rebalance_tick+94/a0>
Trace; fffffc0000339e3c <do_timer+11c/120>
Trace; fffffc000031ca20 <timer_interrupt+a0/180>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000323354 <sable_lynx_srm_device_interrupt+44/60>
Trace; fffffc000031a034 <do_entInt+124/190>
Trace; fffffc0000313160 <ret_from_sys_call+0/10>
Trace; fffffc000046396c <de4x5_interrupt+ec/370>
Trace; fffffc0000319d10 <synchronize_irq+0/50>
Trace; fffffc0000319d40 <synchronize_irq+30/50>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000323354 <sable_lynx_srm_device_interrupt+44/60>
Trace; fffffc000031a034 <do_entInt+124/190>
Trace; fffffc0000313160 <ret_from_sys_call+0/10>
Trace; fffffc0000314fb0 <default_idle+0/10>
Trace; fffffc0000315018 <cpu_idle+58/80>
Trace; fffffc0000314fb0 <default_idle+0/10>
Trace; fffffc0000314fb0 <default_idle+0/10>
Trace; fffffc00003100e0 <rest_init+60/90>
Trace; fffffc000031001c <_stext+1c/20>



Trace; fffffc000032afac <show_state+9c/110>
Trace; fffffc0000429878 <sysrq_handle_showstate+18/30>
Trace; fffffc0000429c04 <__handle_sysrq_nolock+d4/1c0>
Trace; fffffc0000429b08 <handle_sysrq+68/90>
Trace; fffffc0000420404 <kbd_keycode+444/4a0>
Trace; fffffc00004204ac <kbd_event+4c/b0>
Trace; fffffc000048ddac <input_event+16c/4d0>
Trace; fffffc0000490cf4 <atkbd_interrupt+1f4/500>
Trace; fffffc0000495db4 <serio_interrupt+64/70>
Trace; fffffc0000496c08 <i8042_interrupt+b8/230>
Trace; fffffc0000496cc8 <i8042_interrupt+178/230>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000327e34 <rebalance_tick+94/a0>
Trace; fffffc0000339e3c <do_timer+11c/120>
Trace; fffffc000031ca20 <timer_interrupt+a0/180>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000323354 <sable_lynx_srm_device_interrupt+44/60>
Trace; fffffc000031a034 <do_entInt+124/190>
Trace; fffffc0000313160 <ret_from_sys_call+0/10>
Trace; fffffc0000464cbc <set_multicast_list+10c/140>
Trace; fffffc000046396c <de4x5_interrupt+ec/370>
Trace; fffffc0000319d10 <synchronize_irq+0/50>
Trace; fffffc0000319d44 <synchronize_irq+34/50>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000323354 <sable_lynx_srm_device_interrupt+44/60>
Trace; fffffc000046bea8 <type4_infoblock+68/1e0>
Trace; fffffc000031a034 <do_entInt+124/190>
Trace; fffffc0000313160 <ret_from_sys_call+0/10>
Trace; fffffc0000464cbc <set_multicast_list+10c/140>
Trace; fffffc00004b18f4 <dev_activate+f4/150>
Trace; fffffc00004b1520 <pfifo_fast_init+0/40>
Trace; fffffc00004b184c <dev_activate+4c/150>
Trace; fffffc00004a24d8 <dev_open+d8/100>
Trace; fffffc00004a4604 <dev_change_flags+84/1f0>
Trace; fffffc00004f3e14 <devinet_ioctl+384/8f0>
Trace; fffffc00004f78b8 <inet_ioctl+e8/170>
Trace; fffffc00004988c8 <sock_ioctl+148/500>
Trace; fffffc0000390378 <sys_ioctl+188/3d0>
Trace; fffffc0000313144 <entSys+a4/c0>
Trace; fffffc00003130a0 <entSys+0/c0>



Trace; fffffc000032afac <show_state+9c/110>
Trace; fffffc0000429878 <sysrq_handle_showstate+18/30>
Trace; fffffc0000429c04 <__handle_sysrq_nolock+d4/1c0>
Trace; fffffc0000429b08 <handle_sysrq+68/90>
Trace; fffffc0000420404 <kbd_keycode+444/4a0>
Trace; fffffc00004204ac <kbd_event+4c/b0>
Trace; fffffc000048ddac <input_event+16c/4d0>
Trace; fffffc0000490cf4 <atkbd_interrupt+1f4/500>
Trace; fffffc0000495db4 <serio_interrupt+64/70>
Trace; fffffc0000496c08 <i8042_interrupt+b8/230>
Trace; fffffc0000496cc8 <i8042_interrupt+178/230>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000464cbc <set_multicast_list+10c/140>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc00003f9590 <_outb+0/30>
Trace; fffffc0000327e34 <rebalance_tick+94/a0>
Trace; fffffc0000339e3c <do_timer+11c/120>
Trace; fffffc000031ca20 <timer_interrupt+a0/180>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000323354 <sable_lynx_srm_device_interrupt+44/60>
Trace; fffffc000031a034 <do_entInt+124/190>
Trace; fffffc0000313160 <ret_from_sys_call+0/10>
Trace; fffffc0000464cbc <set_multicast_list+10c/140>
Trace; fffffc000046396c <de4x5_interrupt+ec/370>
Trace; fffffc0000319d10 <synchronize_irq+0/50>
Trace; fffffc0000319d44 <synchronize_irq+34/50>
Trace; fffffc0000318514 <handle_IRQ_event+74/e0>
Trace; fffffc0000319768 <handle_irq+108/220>
Trace; fffffc0000323354 <sable_lynx_srm_device_interrupt+44/60>
Trace; fffffc000046bea8 <type4_infoblock+68/1e0>
Trace; fffffc000031a034 <do_entInt+124/190>
Trace; fffffc0000313160 <ret_from_sys_call+0/10>
Trace; fffffc0000464cbc <set_multicast_list+10c/140>
Trace; fffffc00004b18f4 <dev_activate+f4/150>
Trace; fffffc00004b1520 <pfifo_fast_init+0/40>
Trace; fffffc00004b184c <dev_activate+4c/150>
Trace; fffffc00004a24d8 <dev_open+d8/100>
Trace; fffffc00004a4604 <dev_change_flags+84/1f0>
Trace; fffffc00004f3e14 <devinet_ioctl+384/8f0>
Trace; fffffc00004f78b8 <inet_ioctl+e8/170>
Trace; fffffc00004988c8 <sock_ioctl+148/500>
Trace; fffffc0000390378 <sys_ioctl+188/3d0>
Trace; fffffc0000313144 <entSys+a4/c0>
Trace; fffffc00003130a0 <entSys+0/c0>


--=20
Nathan Poznick <kraken@drunkmonkey.org>

Speak not of my debts unless you mean to pay them. - George Herbert


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/iC9LYOn9JTETs+URAlbgAKCikYFpjf8GpdWOm5x0+5d2rePT/wCeOpeT
yjnw7NOFg8iqobTA/YdJHxE=
=mFHu
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
