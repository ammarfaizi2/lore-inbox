Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTDVDUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTDVDUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:20:06 -0400
Received: from mx10.mail.ru ([194.67.23.30]:9230 "EHLO mx10.mail.ru")
	by vger.kernel.org with ESMTP id S262931AbTDVDUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:20:04 -0400
Date: Tue, 22 Apr 2003 10:32:01 +0700
From: Anton Petrusevich <casus@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x high irq contention
Message-ID: <20030422033201.GA523@casus.home.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

This is 2.4.21-pre4aa3, but the same applies to 2.4.20-vanilla, and i
think to any 2.4.x. The NIC is RTL-8139(8139too). I would really like to 
know what could be done in this situation. The machine (p3-1GHz) is almost 
unrespobsible. Yes, there are really network card interrupts. So, here it goes.
# readprofile -m /boot/System.map | sort -nr +2 | head -20
  2600 handle_IRQ_event                          23.2143
   268 system_call                                4.7857
   184 fget                                       3.8333
   123 sock_poll                                  2.5625
   421 kfree                                      2.1927
   101 __free_pages                               2.1042
   288 do_softirq                                 2.0000
   326 skb_copy_and_csum_dev                      1.8523
    56 restore_fpu                                1.7500
   232 send_sig_info                              1.6111
   123 poll_freewait                              1.5375
   174 __wake_up                                  1.3594
   695 do_schedule                                1.2776
    19 sockfs_delete_dentry                       1.1875
    70 del_timer                                  1.0938
   592 save_i387                                  1.0278
    17 ret_from_sys_call                          1.0000
   111 skb_release_data                           0.9911
    58 __generic_copy_to_user                     0.9062
   115 do_pollfd                                  0.8984

-- 
Anton Petrusevich

