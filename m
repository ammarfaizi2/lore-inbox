Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTDVK2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTDVK2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:28:43 -0400
Received: from mail.ithnet.com ([217.64.64.8]:59658 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263056AbTDVK2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:28:40 -0400
Date: Tue, 22 Apr 2003 12:40:42 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Anton Petrusevich <casus@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x high irq contention
Message-Id: <20030422124042.200a3a60.skraw@ithnet.com>
In-Reply-To: <20030422033201.GA523@casus.home.my>
References: <20030422033201.GA523@casus.home.my>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know much about your network load, but if you have a lot, then you
should probably throw away the 8139 network card and use tulip or 3com instead.

Regards,
Stephan


On Tue, 22 Apr 2003 10:32:01 +0700
Anton Petrusevich <casus@mail.ru> wrote:

> Hi people,
> 
> This is 2.4.21-pre4aa3, but the same applies to 2.4.20-vanilla, and i
> think to any 2.4.x. The NIC is RTL-8139(8139too). I would really like to 
> know what could be done in this situation. The machine (p3-1GHz) is almost 
> unrespobsible. Yes, there are really network card interrupts. So, here it
> goes.
> # readprofile -m /boot/System.map | sort -nr +2 | head -20
>   2600 handle_IRQ_event                          23.2143
>    268 system_call                                4.7857
>    184 fget                                       3.8333
>    123 sock_poll                                  2.5625
>    421 kfree                                      2.1927
>    101 __free_pages                               2.1042
>    288 do_softirq                                 2.0000
>    326 skb_copy_and_csum_dev                      1.8523
>     56 restore_fpu                                1.7500
>    232 send_sig_info                              1.6111
>    123 poll_freewait                              1.5375
>    174 __wake_up                                  1.3594
>    695 do_schedule                                1.2776
>     19 sockfs_delete_dentry                       1.1875
>     70 del_timer                                  1.0938
>    592 save_i387                                  1.0278
>     17 ret_from_sys_call                          1.0000
>    111 skb_release_data                           0.9911
>     58 __generic_copy_to_user                     0.9062
>    115 do_pollfd                                  0.8984
> 
> -- 
> Anton Petrusevich
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
