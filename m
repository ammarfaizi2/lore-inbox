Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbQJ0NSu>; Fri, 27 Oct 2000 09:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQJ0NSm>; Fri, 27 Oct 2000 09:18:42 -0400
Received: from dyna252.cygnus.co.uk ([194.130.39.252]:14073 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130470AbQJ0NSM>;
	Fri, 27 Oct 2000 09:18:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001026235728.A6232@suse.cz> 
In-Reply-To: <20001026235728.A6232@suse.cz> 
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: mousedev uses userspace pointers without copy_{to,from}_user
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Oct 2000 14:17:51 +0100
Message-ID: <18835.972652671@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



static ssize_t mousedev_write(struct file * file, const char * buffer, size_t count, loff_t *ppos)
{
        struct mousedev_list *list = file->private_data;
        unsigned char c;
        int i;

        for (i = 0; i < count; i++) {

                c = buffer[i];


oops. Can we make this die horribly on x86, just for a few kernel releases?
Along with turning on spinlock debugging, which would have shown up the USB 
audio problem months ago.



--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
