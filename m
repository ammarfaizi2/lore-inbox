Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVB1AGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVB1AGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVB1AGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:06:12 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57767 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261516AbVB0XkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:40:22 -0500
Message-ID: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Date: Sun, 27 Feb 2005 18:40:20 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [ patch 6/7] drivers/serial/jsm: new serial device driver
Content-Type: multipart/mixed;
 boundary="------------050700090606070005020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050700090606070005020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch is all headers for this device driver.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>

--------------050700090606070005020705
Content-Type: text/plain;
 name="patch6.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch6.jasmine"

diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/digi.h linux-2.6.9.new/drivers/serial/jsm/digi.h
--- linux-2.6.9.orig/drivers/serial/jsm/digi.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/digi.h	2005-02-27 17:14:44.746952168 -0600
@@ -0,0 +1,416 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * $Id: digi.h,v 1.7 2004/09/23 16:08:30 scottk Exp $
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ */
+
+#ifndef __DIGI_H
+#define __DIGI_H
+
+/************************************************************************
+ ***	Definitions for Digi ditty(1) command.
+ ************************************************************************/
+
+/*
+ * Copyright (c) 1988-96 Digi International Inc., All Rights Reserved.
+ */
+
+/************************************************************************
+ * This module provides application access to special Digi
+ * serial line enhancements which are not standard UNIX(tm) features.
+ ************************************************************************/
+
+#if !defined(TIOCMODG)
+
+#define	TIOCMODG	('d'<<8) | 250		/* get modem ctrl state	*/
+#define	TIOCMODS	('d'<<8) | 251		/* set modem ctrl state	*/
+
+#ifndef TIOCM_LE 
+#define		TIOCM_LE	0x01		/* line enable		*/
+#define		TIOCM_DTR	0x02		/* data terminal ready	*/
+#define		TIOCM_RTS	0x04		/* request to send	*/
+#define		TIOCM_ST	0x08		/* secondary transmit	*/
+#define		TIOCM_SR	0x10		/* secondary receive	*/
+#define		TIOCM_CTS	0x20		/* clear to send	*/
+#define		TIOCM_CAR	0x40		/* carrier detect	*/
+#define		TIOCM_RNG	0x80		/* ring	indicator	*/
+#define		TIOCM_DSR	0x100		/* data set ready	*/
+#define		TIOCM_RI	TIOCM_RNG	/* ring (alternate)	*/
+#define		TIOCM_CD	TIOCM_CAR	/* carrier detect (alt)	*/
+#endif
+
+#endif
+
+#if !defined(TIOCMSET)
+#define	TIOCMSET	('d'<<8) | 252		/* set modem ctrl state	*/
+#define	TIOCMGET	('d'<<8) | 253		/* set modem ctrl state	*/
+#endif
+
+#if !defined(TIOCMBIC)
+#define	TIOCMBIC	('d'<<8) | 254		/* set modem ctrl state */
+#define	TIOCMBIS	('d'<<8) | 255		/* set modem ctrl state */
+#endif
+
+
+#if !defined(TIOCSDTR)
+#define	TIOCSDTR	('e'<<8) | 0		/* set DTR		*/
+#define	TIOCCDTR	('e'<<8) | 1		/* clear DTR		*/
+#endif
+
+/************************************************************************
+ * Ioctl command arguments for DIGI parameters.
+ ************************************************************************/
+#define DIGI_GETA	('e'<<8) | 94		/* Read params		*/
+
+#define DIGI_SETA	('e'<<8) | 95		/* Set params		*/
+#define DIGI_SETAW	('e'<<8) | 96		/* Drain & set params	*/
+#define DIGI_SETAF	('e'<<8) | 97		/* Drain, flush & set params */
+
+#define DIGI_KME	('e'<<8) | 98		/* Read/Write Host	*/
+						/* Adapter Memory	*/
+
+#define	DIGI_GETFLOW	('e'<<8) | 99		/* Get startc/stopc flow */
+						/* control characters 	 */
+#define	DIGI_SETFLOW	('e'<<8) | 100		/* Set startc/stopc flow */
+						/* control characters	 */
+#define	DIGI_GETAFLOW	('e'<<8) | 101		/* Get Aux. startc/stopc */
+						/* flow control chars 	 */
+#define	DIGI_SETAFLOW	('e'<<8) | 102		/* Set Aux. startc/stopc */
+						/* flow control chars	 */
+
+#define DIGI_GEDELAY	('d'<<8) | 246		/* Get edelay */
+#define DIGI_SEDELAY	('d'<<8) | 247		/* Set edelay */
+
+struct	digiflow_t {
+	unsigned char	startc;			/* flow cntl start char	*/
+	unsigned char	stopc;			/* flow cntl stop char	*/
+};
+
+#ifdef	FLOW_2200
+#define	F2200_GETA	('e'<<8) | 104		/* Get 2x36 flow cntl flags */
+#define	F2200_SETAW	('e'<<8) | 105		/* Set 2x36 flow cntl flags */
+#define	F2200_MASK	0x03		/* 2200 flow cntl bit mask */
+#define	FCNTL_2200	0x01		/* 2x36 terminal flow cntl */
+#define	PCNTL_2200	0x02		/* 2x36 printer flow cntl  */
+#define	F2200_XON	0xf8
+#define	P2200_XON	0xf9
+#define	F2200_XOFF	0xfa
+#define	P2200_XOFF	0xfb
+
+#define	FXOFF_MASK	0x03		/* 2200 flow status mask   */
+#define	RCVD_FXOFF	0x01		/* 2x36 Terminal XOFF rcvd */
+#define	RCVD_PXOFF	0x02		/* 2x36 Printer XOFF rcvd  */
+#endif
+
+/************************************************************************
+ * Values for digi_flags 
+ ************************************************************************/
+#define DIGI_IXON	0x0001		/* Handle IXON in the FEP	*/
+#define DIGI_FAST	0x0002		/* Fast baud rates		*/
+#define RTSPACE		0x0004		/* RTS input flow control	*/
+#define CTSPACE		0x0008		/* CTS output flow control	*/
+#define DSRPACE		0x0010		/* DSR output flow control	*/
+#define DCDPACE		0x0020		/* DCD output flow control	*/
+#define DTRPACE		0x0040		/* DTR input flow control	*/
+#define DIGI_COOK	0x0080		/* Cooked processing done in FEP */
+#define DIGI_FORCEDCD	0x0100		/* Force carrier		*/
+#define	DIGI_ALTPIN	0x0200		/* Alternate RJ-45 pin config	*/
+#define	DIGI_AIXON	0x0400		/* Aux flow control in fep	*/
+#define	DIGI_PRINTER	0x0800		/* Hold port open for flow cntrl*/
+#define DIGI_PP_INPUT	0x1000		/* Change parallel port to input*/
+#define DIGI_DTR_TOGGLE	0x2000		/* Support DTR Toggle		*/
+#define DIGI_422	0x4000		/* for 422/232 selectable panel */
+#define DIGI_RTS_TOGGLE	0x8000		/* Support RTS Toggle		*/
+
+/************************************************************************
+ * These options are not supported on the comxi.
+ ************************************************************************/
+#define	DIGI_COMXI	(DIGI_FAST|DIGI_COOK|DSRPACE|DCDPACE|DTRPACE)
+
+#define DIGI_PLEN	28		/* String length		*/
+#define	DIGI_TSIZ	10		/* Terminal string len		*/
+
+/************************************************************************
+ * Structure used with ioctl commands for DIGI parameters.
+ ************************************************************************/
+struct digi_t {
+	unsigned short	digi_flags;		/* Flags (see above)	*/
+	unsigned short	digi_maxcps;		/* Max printer CPS	*/
+	unsigned short	digi_maxchar;		/* Max chars in print queue */
+	unsigned short	digi_bufsize;		/* Buffer size		*/
+	unsigned char	digi_onlen;		/* Length of ON string	*/
+	unsigned char	digi_offlen;		/* Length of OFF string	*/
+	char		digi_onstr[DIGI_PLEN];	/* Printer on string	*/
+	char		digi_offstr[DIGI_PLEN];	/* Printer off string	*/
+	char		digi_term[DIGI_TSIZ];	/* terminal string	*/
+};
+
+/************************************************************************
+ * KME definitions and structures.
+ ************************************************************************/
+#define	RW_IDLE		0	/* Operation complete			*/
+#define	RW_READ		1	/* Read Concentrator Memory		*/
+#define	RW_WRITE	2	/* Write Concentrator Memory		*/
+
+struct rw_t {
+	unsigned char	rw_req;		/* Request type			*/
+	unsigned char	rw_board;	/* Host Adapter board number	*/
+	unsigned char	rw_conc;	/* Concentrator number		*/
+	unsigned char	rw_reserved;	/* Reserved for expansion	*/
+	unsigned int	rw_addr;	/* Address in concentrator	*/
+	unsigned short	rw_size;	/* Read/write request length	*/
+	unsigned char	rw_data[128];	/* Data to read/write		*/
+};
+
+/***********************************************************************
+ * Shrink Buffer and Board Information definitions and structures.
+
+ ************************************************************************/
+			/* Board type return codes */
+#define	PCXI_TYPE 1	/* Board type at the designated port is a PC/Xi */
+#define PCXM_TYPE 2	/* Board type at the designated port is a PC/Xm */
+#define	PCXE_TYPE 3	/* Board type at the designated port is a PC/Xe */
+#define	MCXI_TYPE 4	/* Board type at the designated port is a MC/Xi */
+#define COMXI_TYPE 5	/* Board type at the designated port is a COM/Xi */
+
+			 /* Non-Zero Result codes. */
+#define RESULT_NOBDFND 1 /* A Digi product at that port is not config installed */ 
+#define RESULT_NODESCT 2 /* A memory descriptor was not obtainable */ 
+#define RESULT_NOOSSIG 3 /* FEP/OS signature was not detected on the board */
+#define RESULT_TOOSML  4 /* Too small an area to shrink.  */
+#define RESULT_NOCHAN  5 /* Channel structure for the board was not found */
+
+struct shrink_buf_struct {
+	unsigned int	shrink_buf_vaddr;	/* Virtual address of board */
+	unsigned int	shrink_buf_phys;	/* Physical address of board */
+	unsigned int	shrink_buf_bseg;	/* Amount of board memory */
+	unsigned int	shrink_buf_hseg;	/* '186 Begining of Dual-Port */
+
+	unsigned int	shrink_buf_lseg;	/* '186 Begining of freed memory */ 
+	unsigned int	shrink_buf_mseg;	/* Linear address from start of
+						   dual-port were freed memory
+						   begins, host viewpoint. */
+
+	unsigned int	shrink_buf_bdparam;	/* Parameter for xxmemon and
+						   xxmemoff */
+
+	unsigned int	shrink_buf_reserva;	/* Reserved */
+	unsigned int	shrink_buf_reservb;	/* Reserved */
+	unsigned int	shrink_buf_reservc;	/* Reserved */
+	unsigned int	shrink_buf_reservd;	/* Reserved */
+
+	unsigned char	shrink_buf_result;	/* Reason for call failing
+						   Zero is Good return */
+	unsigned char	shrink_buf_init;	/* Non-Zero if it caused an
+						   xxinit call. */
+
+	unsigned char	shrink_buf_anports;	/* Number of async ports  */
+	unsigned char	shrink_buf_snports; 	/* Number of sync  ports */
+	unsigned char	shrink_buf_type;	/* Board type	1 = PC/Xi,
+								2 = PC/Xm,
+								3 = PC/Xe  
+								4 = MC/Xi  
+								5 = COMX/i */
+	unsigned char	shrink_buf_card;	/* Card number */
+	
+};
+
+/************************************************************************
+ * Structure to get driver status information
+ ************************************************************************/
+struct digi_dinfo {
+	unsigned int	dinfo_nboards;		/* # boards configured	*/
+	char		dinfo_reserved[12];	/* for future expansion */
+	char		dinfo_version[16];	/* driver version	*/
+};
+
+#define	DIGI_GETDD	('d'<<8) | 248		/* get driver info	*/
+ 
+/************************************************************************
+ * Structure used with ioctl commands for per-board information
+ *
+ * physsize and memsize differ when board has "windowed" memory
+ ************************************************************************/
+struct digi_info {
+	unsigned int	info_bdnum;		/* Board number (0 based)  */
+	unsigned int	info_ioport;		/* io port address	   */
+	unsigned int	info_physaddr;		/* memory address	   */
+	unsigned int	info_physsize;		/* Size of host mem window */
+	unsigned int	info_memsize;		/* Amount of dual-port mem */
+						/* on board		   */
+	unsigned short	info_bdtype;		/* Board type		   */
+	unsigned short	info_nports;		/* number of ports	   */
+	char		info_bdstate;		/* board state		   */
+	char		info_reserved[7];	/* for future expansion	   */
+};
+
+#define	DIGI_GETBD	('d'<<8) | 249		/* get board info	   */
+ 
+struct digi_stat {
+	unsigned int	info_chan;		/* Channel number (0 based)  */
+	unsigned int	info_brd;		/* Board number (0 based)  */
+	unsigned int	info_cflag;		/* cflag for channel	   */
+	unsigned int	info_iflag;		/* iflag for channel	   */
+	unsigned int	info_oflag;		/* oflag for channel	   */
+	unsigned int	info_mstat;		/* mstat for channel	   */
+	unsigned int	info_tx_data;		/* tx_data for channel	   */
+	unsigned int	info_rx_data;		/* rx_data for channel	   */
+	unsigned int	info_hflow;		/* hflow for channel	   */
+	unsigned int	info_reserved[8];	/* for future expansion    */
+};
+
+#define	DIGI_GETSTAT	('d'<<8) | 244		/* get board info	   */
+/***********************************************************************
+ *
+ * Structure used with ioctl commands for per-channel information
+ *
+ ************************************************************************/
+struct digi_ch {
+	unsigned int	info_bdnum;		/* Board number (0 based)  */
+	unsigned int	info_channel;		/* Channel index number	   */
+	unsigned int	info_ch_cflag;		/* Channel cflag   	   */
+	unsigned int	info_ch_iflag;		/* Channel iflag   	   */
+	unsigned int	info_ch_oflag;		/* Channel oflag   	   */
+	unsigned int	info_chsize;		/* Channel structure size  */
+	unsigned int	info_sleep_stat;	/* sleep status		   */
+	dev_t		info_dev;		/* device number	   */
+	unsigned char	info_initstate;		/* Channel init state	   */
+	unsigned char	info_running;		/* Channel running state   */
+	int		reserved[8];		/* reserved for future use */
+};
+
+/*
+* This structure is used with the DIGI_FEPCMD ioctl to 
+* tell the driver which port to send the command for.
+*/
+struct digi_cmd {
+	int	cmd;
+	int	word;
+	int	ncmds;
+	int	chan; /* channel index (zero based) */
+	int	bdid; /* board index (zero based) */
+};
+
+
+struct digi_getbuffer /* Struct for holding buffer use counts */
+{
+	unsigned long tIn;
+	unsigned long tOut;
+	unsigned long rxbuf;
+	unsigned long txbuf;
+	unsigned long txdone;
+};
+
+struct digi_getcounter
+{
+	unsigned long norun;		/* number of UART overrun errors */
+	unsigned long noflow;		/* number of buffer overflow errors */
+	unsigned long nframe;		/* number of framing errors */
+	unsigned long nparity;		/* number of parity errors */
+	unsigned long nbreak;		/* number of breaks received */
+	unsigned long rbytes;		/* number of received bytes */
+	unsigned long tbytes;		/* number of bytes transmitted fully */
+};
+
+/*
+*  info_sleep_stat defines
+*/
+#define INFO_RUNWAIT	0x0001
+#define INFO_WOPEN	0x0002
+#define INFO_TTIOW	0x0004
+#define INFO_CH_RWAIT	0x0008
+#define INFO_CH_WEMPTY	0x0010
+#define INFO_CH_WLOW	0x0020
+#define INFO_XXBUF_BUSY 0x0040
+
+#define	DIGI_GETCH	('d'<<8) | 245		/* get board info	*/
+
+/* Board type definitions */
+
+#define	SUBTYPE		0007
+#define	T_PCXI		0000
+#define T_PCXM		0001
+#define T_PCXE		0002
+#define T_PCXR		0003
+#define T_SP		0004
+#define T_SP_PLUS	0005
+#define T_HERC		0000
+#define T_HOU		0001
+#define T_LON		0002
+#define T_CHA		0003
+#define FAMILY		0070
+#define T_COMXI		0000
+#define T_PCXX		0010
+#define T_CX		0020
+#define T_EPC		0030
+#define	T_PCLITE	0040
+#define	T_SPXX		0050
+#define	T_AVXX		0060
+#define T_DXB		0070
+#define T_A2K_4_8	0070
+#define BUSTYPE		0700
+#define T_ISABUS	0000
+#define T_MCBUS		0100
+#define	T_EISABUS	0200
+#define	T_PCIBUS	0400
+
+/* Board State Definitions */
+
+#define	BD_RUNNING	0x0
+#define	BD_REASON	0x7f
+#define	BD_NOTFOUND	0x1
+#define	BD_NOIOPORT	0x2
+#define	BD_NOMEM	0x3
+#define	BD_NOBIOS	0x4
+#define	BD_NOFEP	0x5
+#define	BD_FAILED	0x6
+#define BD_ALLOCATED	0x7
+#define BD_TRIBOOT	0x8
+#define	BD_BADKME	0x80
+
+#define DIGI_SPOLL		('d'<<8) | 254  /* change poller rate   */
+
+#define DIGI_SETCUSTOMBAUD	_IOW('e', 106, int)	/* Set integer baud rate */
+#define DIGI_GETCUSTOMBAUD	_IOR('e', 107, int)	/* Get integer baud rate */
+
+#define DIGI_REALPORT_GETBUFFERS ('e'<<8 ) | 108
+#define DIGI_REALPORT_SENDIMMEDIATE ('e'<<8 ) | 109
+#define DIGI_REALPORT_GETCOUNTERS ('e'<<8 ) | 110
+#define DIGI_REALPORT_GETEVENTS ('e'<<8 ) | 111
+
+#define EV_OPU		0x0001		//!<Output paused by client
+#define EV_OPS		0x0002		//!<Output paused by reqular sw flowctrl  
+#define EV_OPX		0x0004		//!<Output paused by extra sw flowctrl
+#define EV_OPH		0x0008		//!<Output paused by hw flowctrl
+#define EV_OPT		0x0800		//!<Output paused for RTS Toggle predelay
+
+#define EV_IPU		0x0010		//!<Input paused unconditionally by user
+#define EV_IPS		0x0020		//!<Input paused by high/low water marks
+#define EV_IPA		0x0400		//!<Input paused by pattern alarm module
+
+#define EV_TXB		0x0040		//!<Transmit break pending
+#define EV_TXI		0x0080		//!<Transmit immediate pending
+#define EV_TXF		0x0100		//!<Transmit flowctrl char pending
+#define EV_RXB		0x0200		//!<Break received
+
+#define EV_OPALL	0x080f		//!<Output pause flags
+#define EV_IPALL	0x0430		//!<Input pause flags
+
+#endif /* DIGI_H */
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/dpacompat.h linux-2.6.9.new/drivers/serial/jsm/dpacompat.h
--- linux-2.6.9.orig/drivers/serial/jsm/dpacompat.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/dpacompat.h	2005-02-27 17:14:44.746952168 -0600
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *      Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *      NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ */
+
+
+/* 
+ * This structure holds data needed for the intelligent <--> nonintelligent 
+ * DPA translation
+ */
+ struct ni_info {
+	int board;
+	int channel;
+	int dtr;
+	int rts;
+	int cts;
+	int dsr;
+	int ri;
+	int dcd;
+	int curtx;
+	int currx;
+	unsigned short iflag;
+	unsigned short oflag;
+	unsigned short cflag;
+	unsigned short lflag;
+
+	unsigned int mstat;
+	unsigned char hflow;
+
+	unsigned char xmit_stopped;
+	unsigned char recv_stopped;
+
+	unsigned int baud;
+};
+
+#define RW_READ		1
+#define RW_WRITE	2
+#define DIGI_KME	('e'<<8) | 98		/* Read/Write Host */
+
+#define SUBTYPE		0007
+#define T_PCXI		0000
+#define T_PCXEM		0001
+#define T_PCXE		0002
+#define T_PCXR		0003
+#define T_SP		0004
+#define T_SP_PLUS	0005
+
+#define T_HERC		0000
+#define T_HOU		0001
+#define T_LON		0002
+#define T_CHA		0003
+
+#define T_NEO		0000
+#define T_CLASSIC	0001
+
+#define FAMILY		0070
+#define T_COMXI		0000
+#define	T_NI		0000
+#define T_PCXX		0010
+#define T_CX		0020
+#define T_EPC		0030
+#define T_PCLITE	0040
+#define T_SPXX		0050
+#define T_AVXX		0060
+#define T_DXB		0070
+#define T_A2K_4_8	0070
+
+#define BUSTYPE		0700
+#define T_ISABUS	0000
+#define T_MCBUS		0100
+#define T_EISABUS	0200
+#define T_PCIBUS	0400
+
+/* Board State Definitions */
+
+#define BD_RUNNING	0x0
+#define BD_REASON	0x7f
+#define BD_NOTFOUND	0x1
+#define BD_NOIOPORT	0x2
+#define BD_NOMEM	0x3
+#define BD_NOBIOS	0x4
+#define BD_NOFEP	0x5
+#define BD_FAILED	0x6
+#define BD_ALLOCATED	0x7
+#define BD_TRIBOOT	0x8
+#define BD_BADKME	0x80
+
+#define DIGI_AIXON	0x0400		/* Aux flow control in fep */
+
+/* Ioctls needed for dpa operation */
+
+#define DIGI_GETDD	('d'<<8) | 248	/* get driver info	*/
+#define DIGI_GETBD	('d'<<8) | 249	/* get board info	*/
+#define DIGI_GET_NI_INFO ('d'<<8) | 250		/* nonintelligent state snfo */
+
+/* Other special ioctls */
+#define DIGI_TIMERIRQ ('d'<<8) | 251	/* Enable/disable RS_TIMER use */
+#define DIGI_LOOPBACK ('d'<<8) | 252	/* Enable/disable UART internal loopback */
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_driver.h linux-2.6.9.new/drivers/serial/jsm/jsm_driver.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_driver.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_driver.h	2005-02-27 17:14:44.747952016 -0600
@@ -0,0 +1,484 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *      Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ *
+ *************************************************************************
+ *
+ * Driver includes
+ *
+ *************************************************************************/
+
+#ifndef __JSM_DRIVER_H
+#define __JSM_DRIVER_H
+
+#include <linux/types.h>	/* To pick up the varions Linux types */
+#include <linux/tty.h>		/* To pick up the various tty structs/defines */
+#include <linux/serial_core.h>
+#include <linux/interrupt.h>	/* For irqreturn_t type */
+#include <linux/module.h>	/* For irqreturn_t type */
+
+#include "jsm_types.h"		/* Additional types needed by the Digi header files */
+#include "digi.h"		/* Digi specific ioctl header */  
+#include "jsm_kcompat.h"	/* Kernel 2.4/2.6 compat includes */
+
+
+/*
+ * Driver identification, error and debugging statments
+ *
+ * In theory, you can change all occurances of "digi" in the next
+ * three lines, and the driver printk's will all automagically change.
+ *
+ * APR((fmt, args, ...));	Always prints message
+ * DPR((fmt, args, ...));	Only prints if JSM_TRACER is defined at
+ *				  compile time and jsm_debug!=0
+ *
+ * TRC_TO_CONSOLE:
+ *	Setting this to 1 will turn on some general function tracing
+ *	resulting in a bunch of extra debugging printks to the console
+ *
+ */
+
+#define	PROCSTR		"jsm"			/* /proc entries	 */
+#define	DEVSTR		"/dev/dg/jsm"		/* /dev entries		 */
+#define	DRVSTR		"jsm"			/* Driver name string 
+						 * displayed by APR	 */
+#define	APR(args)	do {printk(DRVSTR": "); printk args;} while (0)
+
+#define TRC_TO_CONSOLE	1
+
+/*
+ * Debugging levels can be set using debug insmod variable
+ * They can also be compiled out completely.
+ */
+
+#define	DBG_INIT		(jsm_debug & 0x01)
+#define	DBG_BASIC		(jsm_debug & 0x02)
+#define	DBG_CORE		(jsm_debug & 0x04)
+
+#define	DBG_OPEN		(jsm_debug & 0x08)
+#define	DBG_CLOSE		(jsm_debug & 0x10)
+#define	DBG_READ		(jsm_debug & 0x20)
+#define	DBG_WRITE		(jsm_debug & 0x40)
+
+#define	DBG_IOCTL		(jsm_debug & 0x80)
+
+#define	DBG_PROC		(jsm_debug & 0x100)
+#define	DBG_PARAM		(jsm_debug & 0x200)
+#define	DBG_PSCAN		(jsm_debug & 0x400)
+#define	DBG_EVENT		(jsm_debug & 0x800)
+
+#define	DBG_DRAIN		(jsm_debug & 0x1000)
+#define	DBG_MSIGS		(jsm_debug & 0x2000)
+
+#define	DBG_MGMT		(jsm_debug & 0x4000)
+#define	DBG_INTR		(jsm_debug & 0x8000)
+
+#define	DBG_CARR		(jsm_debug & 0x10000)
+
+#if TRC_TO_CONSOLE
+#define PRINTF_TO_CONSOLE(args) { printk(DRVSTR": "); printk args; }
+#else //!defined TRACE_TO_CONSOLE
+#define PRINTF_TO_CONSOLE(args)
+#endif
+
+#define	TRC(args)	{ PRINTF_TO_CONSOLE(args) }
+
+#define DPR_INIT(ARGS)		if (DBG_INIT) TRC(ARGS)
+#define DPR_BASIC(ARGS)		if (DBG_BASIC) TRC(ARGS)
+#define DPR_CORE(ARGS)		if (DBG_CORE) TRC(ARGS)
+#define DPR_OPEN(ARGS)		if (DBG_OPEN)  TRC(ARGS)
+#define DPR_CLOSE(ARGS)		if (DBG_CLOSE)  TRC(ARGS)
+#define DPR_READ(ARGS)		if (DBG_READ)  TRC(ARGS)
+#define DPR_WRITE(ARGS)		if (DBG_WRITE) TRC(ARGS)
+#define DPR_IOCTL(ARGS)		if (DBG_IOCTL) TRC(ARGS)
+#define DPR_PROC(ARGS)		if (DBG_PROC)  TRC(ARGS)
+#define DPR_PARAM(ARGS)		if (DBG_PARAM)  TRC(ARGS)
+#define DPR_PSCAN(ARGS)		if (DBG_PSCAN)  TRC(ARGS)
+#define DPR_EVENT(ARGS)		if (DBG_EVENT)  TRC(ARGS)
+#define DPR_DRAIN(ARGS)		if (DBG_DRAIN)  TRC(ARGS)
+#define DPR_CARR(ARGS)		if (DBG_CARR)  TRC(ARGS)
+#define DPR_MGMT(ARGS)		if (DBG_MGMT)  TRC(ARGS)
+#define DPR_INTR(ARGS)		if (DBG_INTR)  TRC(ARGS)
+#define DPR_MSIGS(ARGS)		if (DBG_MSIGS)  TRC(ARGS)
+#define DPR(ARGS)		if (jsm_debug) TRC(ARGS)
+
+/* Number of boards we support at once. */
+#define	MAXBOARDS	20
+#define	MAXPORTS	8
+#define MAXTTYNAMELEN	200
+
+/* Our 3 magic numbers for our board, channel and unit structs */
+#define JSM_BOARD_MAGIC		0x5c6df104
+#define JSM_CHANNEL_MAGIC	0x6c6df104
+#define JSM_UNIT_MAGIC		0x7c6df104
+
+/* Serial port types */
+#define JSM_SERIAL		0
+
+#define	SERIAL_TYPE_NORMAL	1
+
+#define PORT_NUM(dev)	((dev) & 0x7f)
+#define IS_PRINT(dev)	(((dev) & 0xff) >= 0x80)
+
+/* MAX number of stop characters we will send when our read queue is getting full */
+#define MAX_STOPS_SENT 5
+
+/* 4 extra for alignment play space */
+#define WRITEBUFLEN		((4096) + 4)
+#define MYFLIPLEN		N_TTY_BUF_SIZE
+
+#define jsm_jiffies_from_ms(a) (((a) * HZ) / 1000)
+
+/*
+ * Define a local default termios struct. All ports will be created
+ * with this termios initially.  This is the same structure that is defined
+ * as the default in tty_io.c with the same settings overriden as in serial.c
+ *
+ * In short, this should match the internal serial ports' defaults.
+ */
+#define	DEFAULT_IFLAGS	(ICRNL | IXON)
+#define	DEFAULT_OFLAGS	(OPOST | ONLCR)
+#define	DEFAULT_CFLAGS	(B9600 | CS8 | CREAD | HUPCL | CLOCAL)
+#define	DEFAULT_LFLAGS	(ISIG | ICANON | ECHO | ECHOE | ECHOK | \
+			ECHOCTL | ECHOKE | IEXTEN)
+
+#ifndef _POSIX_VDISABLE
+#define   _POSIX_VDISABLE '\0'
+#endif
+
+#define SNIFF_MAX	65536		/* Sniff buffer size (2^n) */
+#define SNIFF_MASK	(SNIFF_MAX - 1)	/* Sniff wrap mask */
+
+/*
+ * All the possible states the driver can be while being loaded.
+ */
+enum {
+	DRIVER_INITIALIZED = 0,
+	DRIVER_READY
+};
+
+/*
+ * All the possible states the board can be while booting up.
+ */
+enum {
+	BOARD_FAILED = 0,
+	BOARD_FOUND,
+	BOARD_READY
+};
+
+
+/*************************************************************************
+ *
+ * Structures and closely related defines.
+ *
+ *************************************************************************/
+
+struct board_t;
+struct channel_t;
+
+/************************************************************************
+ * Per board operations structure					*
+ ************************************************************************/
+struct board_ops {
+	void (*tasklet) (unsigned long data);
+	JSM_IRQRETURN_TYPE (*intr) (int irq, void *voidbrd, struct pt_regs *regs);
+	void (*uart_init) (struct channel_t *ch);
+	void (*uart_off) (struct channel_t *ch);
+	int  (*drain) (struct tty_struct *tty, uint seconds);
+	void (*param) (struct channel_t *ch);
+	void (*assert_modem_signals) (struct channel_t *ch);
+	void (*flush_uart_write) (struct channel_t *ch);
+	void (*flush_uart_read) (struct channel_t *ch);
+	void (*disable_receiver) (struct channel_t *ch);
+	void (*enable_receiver) (struct channel_t *ch);
+	void (*send_break) (struct channel_t *ch);
+	void (*send_start_character) (struct channel_t *ch);
+	void (*send_stop_character) (struct channel_t *ch);
+	void (*copy_data_from_queue_to_uart) (struct channel_t *ch);
+	uint (*get_uart_bytes_left) (struct channel_t *ch);
+	void (*send_immediate_char) (struct channel_t *ch, unsigned char);
+};
+
+
+/*
+ *	Per-board information
+ */
+struct board_t
+{
+	int		magic;		/* Board Magic number.  */
+	int		boardnum;	/* Board number: 0-32 */
+
+	int		type;		/* Type of board */
+	char		*name;		/* Product Name */
+	u16		vendor;		/* PCI vendor ID */
+	u16		device;		/* PCI device ID */
+	u16		subvendor;	/* PCI subsystem vendor ID */
+	u16		subdevice;	/* PCI subsystem device ID */
+	uchar		rev;		/* PCI revision ID */
+	uint		pci_bus;	/* PCI bus value */
+	uint		pci_slot;	/* PCI slot value */
+	struct pci_dev  *pci_dev;
+	uint		maxports;	/* MAX ports this board can handle */
+
+	spinlock_t	bd_lock;	/* Used to protect board */
+
+	spinlock_t	bd_intr_lock;	/* Used to protect the poller tasklet and
+					 * the interrupt routine from each other.
+					 */
+
+	uint		state;		/* State of card. */
+	wait_queue_head_t state_wait;	/* Place to sleep on for state change */
+
+	struct		tasklet_struct helper_tasklet; /* Poll helper tasklet */
+
+	uint		nasync;		/* Number of ports on card */
+
+	uint		irq;		/* Interrupt request number */
+	ulong		intr_count;	/* Count of interrupts */
+
+	ulong		membase;	/* Start of base memory of the card */
+	ulong		membase_end;	/* End of base memory of the card */
+
+	uchar		*re_map_membase;/* Remapped memory of the card */
+
+	ulong		iobase;		/* Start of io base of the card */
+	ulong		iobase_end;	/* End of io base of the card */
+
+	uint		bd_uart_offset;	/* Space between each UART */
+
+	struct channel_t *channels[MAXPORTS]; /* array of pointers to our channels. */
+
+	struct tty_driver	SerialDriver;
+	char		SerialName[200];
+	struct tty_driver	PrintDriver;
+	char		PrintName[200];
+
+	uint		jsm_Major_Serial_Registered;
+	uint		jsm_Major_TransparentPrint_Registered;
+
+	uint		jsm_Serial_Major;
+	uint		jsm_TransparentPrint_Major;
+
+	uint		TtyRefCnt;
+
+	char		*flipbuf;	/* Our flip buffer, alloced if board is found */
+
+	u16		dpatype;	/* The board "type", as defined by DPA */
+	u16		dpastatus;	/* The board "status", as defined by DPA */
+
+	uint		bd_dividend;	/* Board/UARTs specific dividend */
+
+	struct board_ops *bd_ops;
+
+	/* /proc/<board> entries */
+	struct proc_dir_entry *proc_entry_pointer;
+	struct jsm_proc_entry *jsm_board_table;
+};
+
+
+/************************************************************************ 
+ * Unit flag definitions for un_flags.
+ ************************************************************************/
+#define UN_ISOPEN	0x0001		/* Device is open		*/
+#define UN_CLOSING	0x0002		/* Line is being closed		*/
+#define UN_IMM		0x0004		/* Service immediately		*/
+#define UN_BUSY		0x0008		/* Some work this channel	*/
+#define UN_BREAKI	0x0010		/* Input break received		*/
+#define UN_PWAIT	0x0020		/* Printer waiting for terminal	*/
+#define UN_TIME		0x0040		/* Waiting on time		*/
+#define UN_EMPTY	0x0080		/* Waiting output queue empty	*/
+#define UN_LOW		0x0100		/* Waiting output low water mark*/
+#define UN_EXCL_OPEN	0x0200		/* Open for exclusive use	*/
+#define UN_WOPEN	0x0400		/* Device waiting for open	*/
+#define UN_WIOCTL	0x0800		/* Device waiting for open	*/
+#define UN_HANGUP	0x8000		/* Carrier lost			*/
+
+
+/************************************************************************
+ * Structure for terminal or printer unit. 
+ ************************************************************************/
+struct un_t {
+	int	magic;		/* Unit Magic Number.			*/
+	struct	channel_t *un_ch;
+	ulong	un_time;
+	uint	un_type;
+	uint	un_open_count;	/* Counter of opens to port		*/
+	struct tty_struct *un_tty;/* Pointer to unit tty structure	*/
+	uint	un_flags;	/* Unit flags				*/
+	wait_queue_head_t un_flags_wait; /* Place to sleep to wait on unit */
+	uint	un_dev;		/* Minor device number			*/
+};
+
+
+/************************************************************************ 
+ * Device flag definitions for ch_flags.
+ ************************************************************************/
+#define CH_PRON		0x0001		/* Printer on string		*/
+#define CH_STOP		0x0002		/* Output is stopped		*/
+#define CH_STOPI	0x0004		/* Input is stopped		*/
+#define CH_CD		0x0008		/* Carrier is present		*/
+#define CH_FCAR		0x0010		/* Carrier forced on		*/
+#define CH_HANGUP	0x0020		/* Hangup received		*/
+
+#define CH_RECEIVER_OFF	0x0040		/* Receiver is off		*/
+#define CH_OPENING	0x0080		/* Port in fragile open state	*/
+#define CH_CLOSING	0x0100		/* Port in fragile close state	*/
+#define CH_FIFO_ENABLED 0x0200		/* Port has FIFOs enabled	*/
+#define CH_TX_FIFO_EMPTY 0x0400		/* TX Fifo is completely empty	*/
+#define CH_TX_FIFO_LWM  0x0800		/* TX Fifo is below Low Water	*/
+#define CH_BREAK_SENDING 0x1000		/* Break is being sent		*/
+#define CH_LOOPBACK 0x2000		/* Channel is in lookback mode	*/
+#define CH_FLIPBUF_IN_USE 0x4000	/* Channel's flipbuf is in use	*/
+#define CH_BAUD0	0x08000		/* Used for checking B0 transitions */
+
+/*
+ * Definitions for ch_sniff_flags
+ */
+#define SNIFF_OPEN	0x1
+#define SNIFF_WAIT_DATA	0x2
+#define SNIFF_WAIT_SPACE 0x4
+
+
+/* Our Read/Error/Write queue sizes */
+#define RQUEUEMASK	0x1FFF		/* 8 K - 1 */
+#define EQUEUEMASK	0x1FFF		/* 8 K - 1 */
+#define WQUEUEMASK	0x0FFF		/* 4 K - 1 */
+#define RQUEUESIZE	(RQUEUEMASK + 1)
+#define EQUEUESIZE	RQUEUESIZE
+#define WQUEUESIZE	(WQUEUEMASK + 1)
+
+
+/************************************************************************ 
+ * Channel information structure.
+ ************************************************************************/
+struct channel_t {
+	struct uart_port uart_port;
+	int magic;			/* Channel Magic Number		*/
+	struct board_t	*ch_bd;		/* Board structure pointer	*/
+	struct un_t	ch_tun;		/* Terminal unit info		*/
+	struct un_t	ch_pun;		/* Printer unit info		*/
+
+	spinlock_t	ch_lock;	/* provide for serialization */
+	wait_queue_head_t ch_flags_wait;
+
+	uint		ch_portnum;	/* Port number, 0 offset.	*/
+	uint		ch_open_count;	/* open count			*/
+	uint		ch_flags;	/* Channel flags		*/
+
+	ulong		ch_close_delay;	/* How long we should drop RTS/DTR for */
+
+	ulong		ch_cpstime;	/* Time for CPS calculations	*/
+
+	tcflag_t	ch_c_iflag;	/* channel iflags		*/
+	tcflag_t	ch_c_cflag;	/* channel cflags		*/
+	tcflag_t	ch_c_oflag;	/* channel oflags		*/
+	tcflag_t	ch_c_lflag;	/* channel lflags		*/
+	uchar		ch_stopc;	/* Stop character		*/
+	uchar		ch_startc;	/* Start character		*/
+
+	uint		ch_old_baud;	/* Cache of the current baud */
+	uint		ch_custom_speed;/* Custom baud, if set */
+
+	uint		ch_wopen;	/* Waiting for open process cnt */
+
+	uchar		ch_mostat;	/* FEP output modem status	*/
+	uchar		ch_mistat;	/* FEP input modem status	*/
+
+	struct neo_uart_struct *ch_neo_uart;	/* Pointer to the "mapped" UART struct */
+	uchar		ch_cached_lsr;	/* Cached value of the LSR register */
+
+	uchar		*ch_rqueue;	/* Our read queue buffer - malloc'ed */
+	ushort		ch_r_head;	/* Head location of the read queue */
+	ushort		ch_r_tail;	/* Tail location of the read queue */
+
+	uchar		*ch_equeue;	/* Our error queue buffer - malloc'ed */
+	ushort		ch_e_head;	/* Head location of the error queue */
+	ushort		ch_e_tail;	/* Tail location of the error queue */
+
+	uchar		*ch_wqueue;	/* Our write queue buffer - malloc'ed */
+	ushort		ch_w_head;	/* Head location of the write queue */
+	ushort		ch_w_tail;	/* Tail location of the write queue */
+
+	ulong		ch_rxcount;	/* total of data received so far */
+	ulong		ch_txcount;	/* total of data transmitted so far */
+
+	uchar		ch_r_tlevel;	/* Receive Trigger level */
+	uchar		ch_t_tlevel;	/* Transmit Trigger level */
+
+	uchar		ch_r_watermark;	/* Receive Watermark */
+
+
+	uint		ch_stops_sent;	/* How many times I have sent a stop character
+					 * to try to stop the other guy sending.
+					 */
+	ulong		ch_err_parity;	/* Count of parity errors on channel */
+	ulong		ch_err_frame;	/* Count of framing errors on channel */
+	ulong		ch_err_break;	/* Count of breaks on channel */
+	ulong		ch_err_overrun; /* Count of overruns on channel */
+
+	ulong		ch_xon_sends;	/* Count of xons transmitted */
+	ulong		ch_xoff_sends;	/* Count of xoffs transmitted */
+
+	/* /proc/<board>/<channel> entries */
+	struct proc_dir_entry *proc_entry_pointer;
+	struct jsm_proc_entry *jsm_channel_table;
+
+	uint ch_sniff_in;
+	uint ch_sniff_out;
+	char *ch_sniff_buf;		/* Sniff buffer for proc */
+	ulong ch_sniff_flags;		/* Channel flags	*/
+	wait_queue_head_t ch_sniff_wait;
+};
+
+
+
+/*************************************************************************
+ *
+ * Prototypes for non-static functions used in more than one module
+ *
+ *************************************************************************/
+
+extern void	*jsm_driver_kzmalloc(size_t size, int priority);
+extern char	*jsm_ioctl_name(int cmd);
+
+/*
+ * Our Global Variables.
+ */
+
+extern struct uart_driver jsm_uart_driver;
+
+extern  int		jsm_driver_state;	/* The state of the driver	*/
+extern  uint		jsm_Major;		/* Our driver/mgmt major	*/
+extern  int		jsm_debug;		/* Debug variable		*/
+extern  int		jsm_rawreadok;		/* Set if user wants rawreads	*/
+extern  int		jsm_trcbuf_size;	/* Size of the ringbuffer	*/
+extern  spinlock_t	jsm_global_lock;	/* Driver global spinlock	*/
+extern  uint		jsm_NumBoards;		/* Total number of boards	*/
+extern  struct board_t	*jsm_Board[MAXBOARDS];	/* Array of board structs	*/
+extern  ulong		jsm_poll_counter;	/* Times the poller has run	*/
+extern  char		*jsm_state_text[];	/* Array of state text		*/
+extern  char		*jsm_driver_state_text[];/* Array of driver state text */
+
+
+void jsm_proc_register_basic_prescan(void);
+int jsm_proc_register_basic_postscan(int board_num);
+void jsm_proc_unregister_all(void);
+void jsm_proc_unregister_brd(int board_num);
+
+#endif
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_kcompat.h linux-2.6.9.new/drivers/serial/jsm/jsm_kcompat.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_kcompat.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_kcompat.h	2005-02-27 17:14:44.747952016 -0600
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2004 Digi International (www.digi.com)
+ *      Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ *
+ *************************************************************************
+ *
+ * This file is intended to contain all the kernel "differences" between the
+ * various kernels that we support.
+ *
+ *************************************************************************/
+
+#ifndef __JSM_KCOMPAT_H
+#define __JSM_KCOMPAT_H
+
+# define JSM_MAJOR(x)			(imajor(x))
+# define JSM_MINOR(x)			(iminor(x))
+# define JSM_TTY_MAJOR(tty)		(MAJOR(tty_devnum(tty)))
+# define JSM_TTY_MINOR(tty)		(MINOR(tty_devnum(tty)))
+
+# define JSM_MOD_INC_USE_COUNT(rtn)	(rtn = 1)
+# define JSM_MOD_DEC_USE_COUNT		
+
+# define JSM_IRQRETURN_TYPE		irqreturn_t
+# define JSM_IRQ_RETURN(x)		return x;
+
+# define PARM_GEN_IP			(PDE(file->f_dentry->d_inode))
+
+# define JSM_GET_TTY_COUNT(x)		(x->count)
+
+#endif /* ! __JSM_KCOMPAT_H */
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h	2005-02-27 17:14:44.747952016 -0600
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ */
+
+#ifndef __JSM_MGMT_H
+#define __JSM_MGMT_H
+
+#define MAXMGMTDEVICES 8
+
+int jsm_mgmt_open(struct inode *inode, struct file *file);
+int jsm_mgmt_close(struct inode *inode, struct file *file);
+int jsm_mgmt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+
+#endif
+
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_neo.h linux-2.6.9.new/drivers/serial/jsm/jsm_neo.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_neo.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_neo.h	2005-02-27 17:14:44.748951864 -0600
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ *
+ */
+
+#ifndef __JSM_NEO_H
+#define __JSM_NEO_H
+
+#include "jsm_types.h"
+#include "jsm_driver.h"
+
+/************************************************************************ 
+ * Per channel/port NEO UART structure					*
+ ************************************************************************
+ *		Base Structure Entries Usage Meanings to Host		*
+ *									*
+ *	W = read write		R = read only				* 
+ *			U = Unused.					*
+ ************************************************************************/
+
+struct neo_uart_struct {
+	volatile uchar txrx;		/* WR  RHR/THR - Holding Reg */
+	volatile uchar ier;		/* WR  IER - Interrupt Enable Reg */
+	volatile uchar isr_fcr;		/* WR  ISR/FCR - Interrupt Status Reg/Fifo Control Reg */
+	volatile uchar lcr;		/* WR  LCR - Line Control Reg */
+	volatile uchar mcr;		/* WR  MCR - Modem Control Reg */
+	volatile uchar lsr;		/* WR  LSR - Line Status Reg */
+	volatile uchar msr;		/* WR  MSR - Modem Status Reg */
+	volatile uchar spr;		/* WR  SPR - Scratch Pad Reg */
+	volatile uchar fctr;		/* WR  FCTR - Feature Control Reg */
+	volatile uchar efr;		/* WR  EFR - Enhanced Function Reg */
+	volatile uchar tfifo;		/* WR  TXCNT/TXTRG - Transmit FIFO Reg */	
+	volatile uchar rfifo;		/* WR  RXCNT/RXTRG - Recieve  FIFO Reg */
+	volatile uchar xoffchar1;	/* WR  XOFF 1 - XOff Character 1 Reg */
+	volatile uchar xoffchar2;	/* WR  XOFF 2 - XOff Character 2 Reg */
+	volatile uchar xonchar1;	/* WR  XON 1 - Xon Character 1 Reg */
+	volatile uchar xonchar2;	/* WR  XON 2 - XOn Character 2 Reg */
+
+	volatile uchar reserved1[0x2ff - 0x200]; /* U   Reserved by Exar */
+	volatile uchar txrxburst[64];	/* RW  64 bytes of RX/TX FIFO Data */
+	volatile uchar reserved2[0x37f - 0x340]; /* U   Reserved by Exar */
+	volatile uchar rxburst_with_errors[64];	/* R  64 bytes of RX FIFO Data + LSR */
+};
+
+/* Where to read the extended interrupt register (32bits instead of 8bits) */
+#define	UART_17158_POLL_ADDR_OFFSET	0x80
+
+
+/*
+ * These are the redefinitions for the FCTR on the XR17C158, since
+ * Exar made them different than their earlier design. (XR16C854)
+ */
+
+/* These are only applicable when table D is selected */
+#define UART_17158_FCTR_RTS_NODELAY	0x00
+#define UART_17158_FCTR_RTS_4DELAY	0x01
+#define UART_17158_FCTR_RTS_6DELAY	0x02
+#define UART_17158_FCTR_RTS_8DELAY	0x03
+#define UART_17158_FCTR_RTS_12DELAY	0x12
+#define UART_17158_FCTR_RTS_16DELAY	0x05
+#define UART_17158_FCTR_RTS_20DELAY	0x13
+#define UART_17158_FCTR_RTS_24DELAY	0x06
+#define UART_17158_FCTR_RTS_28DELAY	0x14
+#define UART_17158_FCTR_RTS_32DELAY	0x07
+#define UART_17158_FCTR_RTS_36DELAY	0x16
+#define UART_17158_FCTR_RTS_40DELAY	0x08
+#define UART_17158_FCTR_RTS_44DELAY	0x09
+#define UART_17158_FCTR_RTS_48DELAY	0x10
+#define UART_17158_FCTR_RTS_52DELAY	0x11
+
+#define UART_17158_FCTR_RTS_IRDA	0x10
+#define UART_17158_FCTR_RS485		0x20
+#define UART_17158_FCTR_TRGA		0x00
+#define UART_17158_FCTR_TRGB		0x40
+#define UART_17158_FCTR_TRGC		0x80
+#define UART_17158_FCTR_TRGD		0xC0
+
+/* 17158 trigger table selects.. */
+#define UART_17158_FCTR_BIT6		0x40
+#define UART_17158_FCTR_BIT7		0x80
+
+/* 17158 TX/RX memmapped buffer offsets */
+#define UART_17158_RX_FIFOSIZE		64  
+#define UART_17158_TX_FIFOSIZE		64  
+
+/* 17158 Extended IIR's */
+#define UART_17158_IIR_RDI_TIMEOUT	0x0C	/* Receiver data TIMEOUT */
+#define UART_17158_IIR_XONXOFF		0x10	/* Received an XON/XOFF char */
+#define UART_17158_IIR_HWFLOW_STATE_CHANGE 0x20	/* CTS/DSR or RTS/DTR state change */
+#define UART_17158_IIR_FIFO_ENABLED	0xC0	/* 16550 FIFOs are Enabled */
+
+/*
+ * These are the extended interrupts that get sent
+ * back to us from the UART's 32bit interrupt register
+ */
+#define UART_17158_RX_LINE_STATUS	0x1	/* RX Ready */
+#define UART_17158_RXRDY_TIMEOUT	0x2	/* RX Ready Timeout */
+#define UART_17158_TXRDY		0x3	/* TX Ready */
+#define UART_17158_MSR			0x4	/* Modem State Change */
+#define UART_17158_TX_AND_FIFO_CLR	0x40	/* Transmitter Holding Reg Empty */
+#define UART_17158_RX_FIFO_DATA_ERROR	0x80	/* UART detected an RX FIFO Data error */
+
+/*
+ * These are the EXTENDED definitions for the 17C158's Interrupt
+ * Enable Register.
+ */
+#define UART_17158_EFR_ECB	0x10	/* Enhanced control bit */
+#define UART_17158_EFR_IXON	0x2	/* Receiver compares Xon1/Xoff1 */
+#define UART_17158_EFR_IXOFF	0x8	/* Transmit Xon1/Xoff1 */
+#define UART_17158_EFR_RTSDTR	0x40	/* Auto RTS/DTR Flow Control Enable */
+#define UART_17158_EFR_CTSDSR	0x80	/* Auto CTS/DSR Flow COntrol Enable */
+
+#define UART_17158_XOFF_DETECT	0x1	/* Indicates whether chip saw an incoming XOFF char  */
+#define UART_17158_XON_DETECT	0x2	/* Indicates whether chip saw an incoming XON char */
+
+#define UART_17158_IER_RSVD1	0x10	/* Reserved by Exar */
+#define UART_17158_IER_XOFF	0x20	/* Xoff Interrupt Enable */
+#define UART_17158_IER_RTSDTR	0x40	/* Output Interrupt Enable */
+#define UART_17158_IER_CTSDSR	0x80	/* Input Interrupt Enable */
+
+/*
+ * Our Global Variables
+ */
+extern struct board_ops jsm_neo_ops;
+
+#endif
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_pci.h linux-2.6.9.new/drivers/serial/jsm/jsm_pci.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_pci.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_pci.h	2005-02-27 17:14:44.748951864 -0600
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ */
+
+/* $Id: jsm_pci.h,v 1.4 2004/01/06 16:44:49 scottk Exp $ */
+
+#ifndef __DGAP_PCI_H
+#define __DGAP_PCI_H
+
+#define PCIMAX 32			/* maximum number of PCI boards */
+
+#define DIGI_VID				0x114F
+
+#define PCI_DEVICE_NEO_4_DID			0x00B0
+#define PCI_DEVICE_NEO_8_DID			0x00B1
+#define PCI_DEVICE_NEO_2DB9_DID			0x00C8
+#define PCI_DEVICE_NEO_2DB9PRI_DID		0x00C9
+#define PCI_DEVICE_NEO_2RJ45_DID		0x00CA
+#define PCI_DEVICE_NEO_2RJ45PRI_DID		0x00CB
+#define PCI_DEVICE_NEO_1_422_DID		0x00CC
+#define PCI_DEVICE_NEO_1_422_485_DID		0x00CD
+#define PCI_DEVICE_NEO_2_422_485_DID		0x00CE
+
+
+#define PCI_DEVICE_NEO_4_PCI_NAME		"Neo 4 PCI"
+#define PCI_DEVICE_NEO_8_PCI_NAME		"Neo 8 PCI"
+#define PCI_DEVICE_NEO_2DB9_PCI_NAME		"Neo 2 - DB9 Universal PCI"
+#define PCI_DEVICE_NEO_2DB9PRI_PCI_NAME		"Neo 2 - DB9 Universal PCI - Powered Ring Indicator"
+#define PCI_DEVICE_NEO_2RJ45_PCI_NAME		"Neo 2 - RJ45 Universal PCI"
+#define PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME	"Neo 2 - RJ45 Universal PCI - Powered Ring Indicator"
+#define PCI_DEVICE_NEO_1_422_PCI_NAME		"Neo 1 422 PCI"
+#define PCI_DEVICE_NEO_1_422_485_PCI_NAME	"Neo 1 422/485 PCI"
+#define PCI_DEVICE_NEO_2_422_485_PCI_NAME	"Neo 2 422/485 PCI"
+
+
+/* Size of Memory and I/O for PCI (4 K) */
+#define PCI_RAM_SIZE				0x1000
+
+/* Size of Memory (2MB) */
+#define PCI_MEM_SIZE				0x1000
+
+#endif
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.h linux-2.6.9.new/drivers/serial/jsm/jsm_tty.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_tty.h	2005-02-27 17:14:44.748951864 -0600
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ */
+
+#ifndef __JSM_TTY_H
+#define __JSM_TTY_H
+
+#include "jsm_driver.h"
+
+int	jsm_tty_write(struct uart_port *port);
+int	jsm_tty_register(struct board_t *brd);
+
+int	jsm_tty_init(struct board_t *);
+int	jsm_uart_port_init(struct board_t *);
+int	jsm_remove_uart_port(struct board_t *);
+
+void	jsm_tty_uninit(struct board_t *);
+
+void	jsm_input(struct channel_t *ch);
+void	jsm_carrier(struct channel_t *ch);
+void	jsm_check_queue_flow_control(struct channel_t *ch);
+void	neo_clear_break(struct channel_t *ch, int force);
+
+
+void	jsm_sniff_nowait_nolock(struct channel_t *ch, uchar *text, uchar *buf, int nbuf);
+
+#endif
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h linux-2.6.9.new/drivers/serial/jsm/jsm_types.h
--- linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/jsm_types.h	2005-02-27 17:14:44.749951712 -0600
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2003 Digi International (www.digi.com)
+ *	Scott H Kilau <Scott_Kilau at digi dot com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE.  See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
+ */
+
+#ifndef __JSM_TYPES_H
+#define __JSM_TYPES_H
+
+#ifndef TRUE
+# define TRUE 1
+#endif
+
+#ifndef FALSE
+# define FALSE 0
+#endif
+
+/* Required for our shared headers! */
+typedef unsigned char uchar;
+
+#endif

--------------050700090606070005020705--

