Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278630AbRJ1SEZ>; Sun, 28 Oct 2001 13:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278629AbRJ1SEP>; Sun, 28 Oct 2001 13:04:15 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:19461 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278617AbRJ1SEC>;
	Sun, 28 Oct 2001 13:04:02 -0500
Date: Sun, 28 Oct 2001 10:03:17 -0800
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13 errors and warnings
Message-ID: <20011028100317.C8059@kroah.com>
In-Reply-To: <27909.1004263116@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27909.1004263116@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 08:58:36PM +1100, Keith Owens wrote:
> 
> drivers/usb/serial/belkin_sa.c:106: warning: `id_table_combined' defined but not used
> drivers/usb/serial/digi_acceleport.c:480: warning: `id_table_combined' defined but not used
> drivers/usb/serial/ftdi_sio.c:137: warning: `id_table_combined' defined but not used
> drivers/usb/serial/io_tables.h:33: warning: `id_table_combined' defined but not used
> drivers/usb/serial/keyspan.h:349: warning: `keyspan_ids_combined' defined but not used
> drivers/usb/serial/keyspan_pda.c:146: warning: `id_table_combined' defined but not used
> drivers/usb/serial/mct_u232.c:129: warning: `id_table_combined' defined but not used
> drivers/usb/serial/visor.c:171: warning: `id_table' defined but not used
> drivers/usb/serial/whiteheat.c:116: warning: `id_table_combined' defined but not used

These, and lots of the other pci_id table warnings are due to the tables
being used for MODULE_DEVICE_TABLE() information.  When the code is not
compiled as modules, those tables are not needed.

Hm, I guess I should look into some kind of macro to keep this from
happening...

thanks,

greg k-h
