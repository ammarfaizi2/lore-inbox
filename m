Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314338AbSEFKCz>; Mon, 6 May 2002 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSEFKCx>; Mon, 6 May 2002 06:02:53 -0400
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:16699 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S314338AbSEFKCs>; Mon, 6 May 2002 06:02:48 -0400
Message-Id: <200205061002.AA00094@prism.kumin.ne.jp>
Date: Mon, 06 May 2002 19:02:36 +0900
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14  Kernel panic
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <3CD64412.A59C09A@cinet.co.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>You will get more information by showing symbol.
>Use ksymoops or do symbolize virtual address by hand (using ``System.map'').
>``Call Trace'' may be useful.

I boot up linux-2.5.14 to use vga=771 parameter, Now I boot up linux-2.5.14
to unuse vga parameter, then linux-2.5.14 boot up.

>> Call Trace: [<c01ab1a7>] [<c01a96c4>] [<c01a96df>] [<c01747d4>] [<c0177f57>]
>>    [<c01a66f1>] [<c0105023>] [<c010553c>]

I extracted Call Trace address( nearly ) from /boot/System.map. Is it OK?

c0104000 T empty_zero_page
c0105000 T _stext
c0105000 T stext
c0105000 t rest_init
c010501c t init
c0105140 T prepare_namespace
c0105220 T thread_saved_pc
c0105230 T disable_hlt
...
c01745e0 t set_cursor
c0174660 t set_origin
c01746f4 T redraw_screen
c017483c T vc_cons_allocated
c017485c t visual_init
c017493c T vc_allocate
...
c0177cbc t con_close
c0177cf4 t vc_init
c0177df8 t clear_buffer_attributes
c0177e64 T take_over_console
c0177ff4 T give_up_console
c0178020 t set_vesa_blanking
c017803c t vesa_powerdown
...
c01a6514 t fb_open
c01a6598 t fb_release
c01a65f0 T register_framebuffer
c01a671c T unregister_framebuffer
c01a67a0 T fb_alloc_cmap
c01a68a4 T fb_copy_cmap
c01a6ae4 T fb_get_cmap
...
c01a93c4 t fbcon_bmove_rec
c01a9554 t fbcon_switch
c01a971c t fbcon_blank
c01a9938 t fbcon_free_font
...
c01ab05c T gen_get_cmap
c01ab088 T fbgen_set_cmap
c01ab11c T gen_set_cmap
c01ab1b4 T fbgen_pan_display
c01ab274 T fbgen_do_set_var
...

=====

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
